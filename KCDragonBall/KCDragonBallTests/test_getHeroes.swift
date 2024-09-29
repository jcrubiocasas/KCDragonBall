//
//  test_getHeroes.swift
//  KCDragonBallTests
//
//  Created by Juan Carlos Rubio Casas on 28/9/24.
//

import XCTest
@testable import KCDragonBall

final class GetHeroesTests: XCTestCase {
    
    var sut: NetworkModel!
    var mockClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient()
        sut = NetworkModel(client: mockClient)
        // Asignamos manualmente el token antes de ejecutar la prueba
        sut.token = "eeyJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUiLCJ0eXAiOiJKV1QifQ.eyJleHBpcmF0aW9uIjo2NDA5MjIxMTIwMCwiaWRlbnRpZnkiOiI3QUI4QUM0RC1BRDhGLTRBQ0UtQUE0NS0yMUU4NEFFOEJCRTciLCJlbWFpbCI6ImJlamxAa2VlcGNvZGluZy5lcyJ9.vC7UG0hYjQvdbvls8IytPP_XRZKwA3LAr7Z8mSMbwJA"
    }

    
    override func tearDown() {
        sut = nil
        mockClient = nil
        super.tearDown()
    }
    
    // Prueba para obtener héroes exitosamente
    func testGetHeroesSuccess() {
        let expectation = self.expectation(description: "GetHeroesSuccess")
        // Simulamos una lista de héroes como respuesta
        let mockHeroes = [Hero(id: "1", name: "Goku", description: "", favorite: false, photo: "")]
        mockClient.herosResult = .success(mockHeroes) // Usamos Result<[Hero], NetworkError> con éxito
        
        // Ejecutamos el método getHeroes
        sut.getHeroes { result in
            switch result {
                case .success(let heroes):
                    // Verificamos que la lista de héroes tenga los datos esperados
                    XCTAssertEqual(heroes.count, 1)
                    XCTAssertEqual(heroes.first?.name, "Goku")
                    expectation.fulfill() // Cumplimos la expectativa
                case .failure:
                    XCTFail("La obtención de héroes debería haber sido exitosa")
            }
        }
        
        // Esperamos que la expectativa se cumpla en un tiempo límite de 5 segundos
        waitForExpectations(timeout: 5.0)
    }
    
    // Prueba para fallo al obtener héroes
    func testGetHeroesFailure() {
        let expectation = self.expectation(description: "GetHeroesFailure")
        
        // Simulamos un fallo en la respuesta del API
        mockClient.herosResult = .failure(.unknown) // Usamos Result<[Hero], NetworkError> con fallo
        
        // Ejecutamos el método getHeroes
        sut.getHeroes { result in
            switch result {
                case .success:
                    XCTFail("La obtención de héroes no debería haber sido exitosa")
                case .failure(let error):
                    // Verificamos que el error recibido sea el esperado
                    XCTAssertEqual(error, .unknown)
                    expectation.fulfill() // Cumplimos la expectativa
            }
        }
        
        // Esperamos que la expectativa se cumpla en un tiempo límite de 5 segundos
        waitForExpectations(timeout: 5.0)
    }
}
