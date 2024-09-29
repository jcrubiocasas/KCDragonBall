//
//  MockAPIClient.swift
//  KCDragonBallTests
//
//  Created by Juan Carlos Rubio Casas on 28/9/24.
//

import XCTest
@testable import KCDragonBall

class MockAPIClient: APIClientProtocol {
    
    var jwtResult: Result<String, NetworkError>? // Resultado específico para jwt
    var herosResult: Result<[Hero], NetworkError>? // Resultado específico para request de héroes
    var transformationsResult: Result<[Transformation], NetworkError>? // Resultado específico para transformaciones
    
    func jwt(_ request: URLRequest, completion: @escaping (Result<String, NetworkError>) -> Void) {
        if let jwtResult = jwtResult {
            completion(jwtResult)
        } else {
            completion(.failure(.unknown)) // Valor por defecto si no se configura jwtResult
        }
    }
    
    func request<T>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        // Verificamos si el tipo es `Transformation`
        if T.self == [Hero].self, let requestResult = herosResult as? Result<T, NetworkError> {
            completion(requestResult)
        } else if T.self == [Transformation].self, let transformationsResult = transformationsResult as? Result<T, NetworkError> {
            completion(transformationsResult)
        } else {
            completion(.failure(.unknown))
        }
    }
}
/*
class MockAPIClient: APIClientProtocol {
    
    var jwtResult: Result<String, NetworkError>? // Resultado específico para jwt
    var requestResult: Result<[Hero], NetworkError>? // Resultado específico para request
        
    func jwt(_ request: URLRequest, completion: @escaping (Result<String, NetworkError>) -> Void) {
        if let jwtResult = jwtResult {
            completion(jwtResult)
        } else {
            completion(.failure(.unknown)) // Valor por defecto si no se configura jwtResult
        }
    }
    
    func request<T>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        if let requestResult = requestResult as? Result<T, NetworkError> {
            completion(requestResult)
        } else {
            completion(.failure(.unknown))
        }
        }
}
*/
