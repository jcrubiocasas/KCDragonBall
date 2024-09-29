//
//  NetworkModel.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 25/9/24.
//

import Foundation

final class NetworkModel {
    static let shared = NetworkModel()
    
    //https://dragonball.keepcoding.education
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    // Variable public para poder usarla en los test
    var token: String?
    private var heroes: [Hero] = []
    private var transformations: [Transformation] = []
    private let client: APIClientProtocol
    
    // Instancia de AudioPlayer como propiedad de la clase
    private let audioPlayer = AudioPlayer()
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    // Método para iniciar la reproduccion de música
    func playMusic() {
        audioPlayer.playMusic()
    }
    
    // Método para detener la reproduccion de música
    func stopMusic() {
        audioPlayer.stopMusic()
    }
    
    // Metodo para hacer login en la app
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        //https://dragonball.keepcoding.education/api/auth/login
        var components = baseComponents
        components.path = "/api/auth/login"
        // Verificamos que es una URL valida
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        // Creamos la string de login con formato auth basic use:password
        // jcrubio@equinsa.es:123456
        let loginString = String(format: "%@:%@", user, password)
        // Codificamos en UTF8
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.noData))
            return
        }
        // Encryptamos el login en base 64
        let base64LoginString = loginData.base64EncodedString()
        // Creamos una request con la url valida
        var request = URLRequest(url: url)
        // Configuramos metodo POST
        request.httpMethod = "POST"
        // Establecemos la cabecera de auth basic
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        // Instanciamos client.jwt pasando el request
        client.jwt(request) { [weak self] result in
            switch result {
                case let .success(token):
                    // Todo correcto, abtenemos y guardamos token
                    self?.token = token
                case .failure:
                    // Se produjo alfun error
                    break
            }
            completion(result)
        }
    }
    
    func getHeroes(
        completion: @escaping (Result<[Hero], NetworkError>) -> Void
    ) {
        //https://dragonball.keepcoding.education/api/heros/all
        var components = baseComponents
        components.path = "/api/heros/all"
        // Verificamos que es una URL valida
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        // Agregamos JSON al body del request con name="" para obtener todos los heroes
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["name": ""]) else {
            completion(.failure(.unknown))
            return
        }
        // En caso de no tener token se genera error
        guard let token else {
            completion(.failure(.unknown))
            return
        }
        // Creamos request con la URL valida
        var request = URLRequest(url: url)
        // Configuramos metodo POST
        request.httpMethod = "POST"
        // Configuramos cabecera con auth "Bearer token"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        // Establecemos cabecera Content-Type
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        // Establecemos body
        request.httpBody = serializedBody
        // Instanciamos cliente.request, pasandole request y un array de Hero
        client.request(request, using: [Hero].self, completion: completion)
    }
    
    func getTransformations(
        for hero: Hero,
        completion: @escaping (Result<[Transformation], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        // Verificamos que sea una URL valida
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        // Agregamos JSON al body del request con id="hero.id" seleccionado, para obtener todas las transformacionnes de un heroe en concreto
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["id": hero.id]) else {
            completion(.failure(.unknown))
            return
        }
        // En caso de no tener token se genera error
        guard let token else {
            completion(.failure(.unknown))
            return
        }
        // Creamos request con la URL valida
        var request = URLRequest(url: url)
        // Configuramos metodo POST
        request.httpMethod = "POST"
        // Configuramos cabecera con auth "Bearer token"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        // Establecemos cabecera Content-Type
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        // Establecemos body
        request.httpBody = serializedBody
        // Instanciamos cliente.request, pasandole request y un array de Transformation
        client.request(request, using: [Transformation].self, completion: completion)
    }
}
