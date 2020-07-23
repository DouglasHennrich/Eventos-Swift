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
    
    // MARK: - The request function to get results in an Observable
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
            
            // Trigger the HttpRequest using AlamoFire (AF)
            AF.request(urlRequestConvirtable)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        return onCompletion(.success(value))
                        
                    case .failure(let error):
                        switch response.response?.statusCode {
                        case 400:
                            return onCompletion(.failure(ServiceError.badRequest))
                        case 403:
                            return onCompletion(.failure(ServiceError.forbidden))
                        case 404:
                            return onCompletion(.failure(ServiceError.notFound))
                        case 500:
                            return onCompletion(.failure(ServiceError.internalServerError))
                        default:
                            return onCompletion(.failure(error))
                        }
                    }
            }
    }
    
}
