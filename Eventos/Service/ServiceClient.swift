//
//  ServiceClient.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceClientDelegate: AnyObject {
    func request<T: Codable>(withUrl: String,
                             withMethod: HTTPMethod,
                             andParameters: Parameters?,
                             onCompletion: @escaping ((Result<T?, Error>) -> Void))
}

class ServiceClient {
    
    // MARK: Properties
    lazy var logger = Logger.forClass(Self.self)
    
    // MARK: Init
    init() {
        AF.sessionConfiguration.timeoutIntervalForRequest = 15
    }
    
    // MARK: Actions
    func buildUrl(path: String,
                  method: HTTPMethod,
                  parameters: Parameters?) throws -> URLRequestConvertible {
        
        let url = try ServiceConstants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(
            ServiceConstants.ContentType.json.rawValue,
            forHTTPHeaderField: ServiceConstants.HttpHeaderField.acceptType.rawValue)
        
        urlRequest.setValue(
            ServiceConstants.ContentType.json.rawValue,
            forHTTPHeaderField: ServiceConstants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension ServiceClient: ServiceClientDelegate {
    
    //
    func request<T: Codable> (withUrl: String,
                              withMethod: HTTPMethod = .get,
                              andParameters: Parameters? = nil,
                              onCompletion: @escaping ((Result<T?, Error>) -> Void)) {
        
            guard let urlRequestConvirtable = try? self.buildUrl(
                        path: withUrl,
                        method: withMethod,
                        parameters: andParameters)
                else {
                    return onCompletion(.failure(ServiceError.cantCreateUrl))
            }
            
            //
            AF.request(urlRequestConvirtable)
                .responseJSON { [weak self] response in
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else {
                            return onCompletion(.failure(ServiceError.badRequest))
                        }
                        
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            return onCompletion(.success(result))
                        } catch let errorCatch as NSError {
                            self?.logger.error(errorCatch.debugDescription)
                            return onCompletion(.failure(ServiceError.badRequest))
                        }
                        
                    case .failure(let error):
                        switch response.response?.statusCode {
                        case 400:
                            return onCompletion(.failure(ServiceError.badRequest))
                        case 404:
                            return onCompletion(.failure(ServiceError.notFound))
                        case 500:
                            return onCompletion(.failure(ServiceError.internalServerError))
                        default:
                            return onCompletion(.failure(ServiceError.unknow(error: error)))
                        }
                    }
            }
    }
    
}
