//
//  LoginTests.swift
//  KCDragonBallTests
//
//  Created by Juan Carlos Rubio Casas on 28/9/24.
//

import XCTest
@testable import KCDragonBall

final class LoginTests: XCTestCase {
    
    // System Under Test (sut) y mock client
    var sut: NetworkModel!
    var mockClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        // Se inicializa el mock del API client
        mockClient = MockAPIClient()
        // Inyectamos el mock en el modelo de red
        sut = NetworkModel(client: mockClient)
    }
    
    override func tearDown() {
        // Liberamos la memoria asignada al mock y al modelo de red
        sut = nil
        mockClient = nil
        super.tearDown()
    }
    
    // Prueba para login exitoso
    func testLoginSuccess() {
        // Expectativa para manejo de código asíncrono
        let expectation = self.expectation(description: "LoginSuccess")
        
        // Simulamos un token válido como respuesta del login
        mockClient.jwtResult = .success("token")
        
        // Ejecutamos el método login
        sut.login(user: "usuario", password: "clave") { result in
            switch result {
                case .success(let token):
                    // Verificamos que el token recibido sea el esperado
                    XCTAssertEqual(token, "token")
                    expectation.fulfill() // Cumplimos la expectativa
                case .failure:
                    XCTFail("Login debería haber sido exitoso")
            }
        }
        // Esperamos que la expectativa se cumpla en un tiempo maximo de 5 segundos
        waitForExpectations(timeout: 5.0)
    }
    
    // Prueba para un login fallido
    func testLoginFailure() {
        let expectation = self.expectation(description: "LoginFailure")
        
        // Simulamos un error en la respuesta del login
        mockClient.jwtResult = .failure(.unknown)
        
        // Ejecutamos el método login
        sut.login(user: "usuario", password: "clave") { result in
            switch result {
                case .success:
                    XCTFail("Login no debería haber sido exitoso")
                case .failure(let error):
                    // Verificamos que el error recibido sea el esperado
                    XCTAssertEqual(error, .unknown)
                    expectation.fulfill() // Cumplimos la expectativa
            }
        }
        // Esperamos que la expectativa se cumpla en un tiempo maximo de 5 segundos
        waitForExpectations(timeout: 5.0)
    }
}
