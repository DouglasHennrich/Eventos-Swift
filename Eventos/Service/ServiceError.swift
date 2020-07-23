//
//  ServiceError.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case badRequest             // Status code 400
    case forbidden              // Status code 403
    case notFound               // Status code 404
    case internalServerError    // Status code 500
    
    case cantCreateUrl
    case noService
    case unknow(error: Error)
    
    var message: String {
        switch self {
        case .badRequest:
            return "API inválida"
        case .forbidden:
            return "API não autorizada"
        case .notFound:
            return "API não encontrada"
        case .internalServerError:
            return "Erro na API"
            
        case .cantCreateUrl:
            return "Erro ao montar a API"
            
        case .noService:
            return "Sem serviço"
            
        case .unknow(let error):            
            return (error as NSError).debugDescription
        }
    }
}
