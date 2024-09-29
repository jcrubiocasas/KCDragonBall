//
//  APIClient.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 25/9/24.
//


import Foundation

protocol APIClientProtocol {
    // Protocolo para el login
    func jwt(
        _ request: URLRequest,
        completion: @escaping (Result<String, NetworkError>) -> Void
    )
    // Protocolo para el request de [Hero] o [Transformations]
    func request<T: Codable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

struct APIClient: APIClientProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
     
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        // Se realiza una peticion HTTP a la URL y segun el request y tipo que nos pasan
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<T, NetworkError>
            
            // Ejecutar al final para retornar el resultado
            defer {
                completion(result)
            }
            // Si se produce un error se interrumpo
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            // Si no hay datos se interrumpe
            guard let data else {
                result = .failure(.noData)
                return
            }
            // Obtenemos el StatusCode
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            // Segun la documentacion del API filltramos como OK HTTP 200 en caso contrario error
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            // Decodificamos el JSON obtenido segun el moodelo de datos que nos han pasado
            guard let model = try? JSONDecoder().decode(using, from: data) else {
                result = .failure(.decodingFailed)
                return
            }
            // Retornamos el modelo de datos [Hero] o [Transformations]
            result = .success(model)
        }
        task.resume()
    }
    
    // Se realiza una peticion HTTP segun el request que nos pasan
    func jwt(
        _ request: URLRequest,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        // Se realiza una peticion HTTP a la URL y segun el request que nos pasan
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<String, NetworkError>
            // Se ejecuta al final para retornar el resultado
            defer {
                completion(result)
            }
            // Si se producce error se interrumpe
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            // Si nos hay datos se interrumpe
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            // Obtenemso el StatusCode de la respuuesta HTTP
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            // Segun la documentacion del API filltramos como OK HTTP 200 en caso contrario error
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            // Segun la documentacion del API se retorna texto que es el token
            // Lo gardamos en la costante token
            guard let token = String(data: data, encoding: .utf8) else {
                result = .failure(.decodingFailed)
                return
            }
            // Retornamos token
            result = .success(token)
        }
        
        task.resume()
    }
}
