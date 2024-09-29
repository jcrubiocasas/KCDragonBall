//
//  test_getTransformations.swift
//  KCDragonBallTests
//
//  Created by Juan Carlos Rubio Casas on 28/9/24.
//

import XCTest
@testable import KCDragonBall

final class GetTransformationsTests: XCTestCase {
    
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
    
    // Prueba para obtener transformaciones exitosamente
    func testGetTransformationsSuccess() {
        let expectation = self.expectation(description: "GetTransformationsSuccess")
        
        // Simulamos una lista de transformaciones como respuesta
        let mockTransformations = [Transformation(id: "1", photo: "", name: "Super Saiyan", description: "Goku's first transformation")]
        mockClient.transformationsResult = .success(mockTransformations) // Usamos Result<[Transformation], NetworkError> con éxito
        
        // Creamos un héroe simulado
        let hero = Hero(id: "1", name: "Goku", description: "", favorite: false, photo: "")
        
        // Ejecutamos el método getTransformations
        sut.getTransformations(for: hero) { result in
            switch result {
                case .success(let transformations):
                    // Verificamos que la lista de transformaciones tenga los datos esperados
                    XCTAssertEqual(transformations.count, 1)
                    XCTAssertEqual(transformations.first?.name, "Super Saiyan")
                    XCTAssertEqual(transformations.first?.description, "Goku's first transformation")
                    expectation.fulfill() // Cumplimos la expectativa
                case .failure:
                    XCTFail("La obtención de transformaciones debería haber sido exitosa")
            }
        }
        
        // Esperamos que la expectativa se cumpla en un tiempo límite de 5 segundos
        waitForExpectations(timeout: 5.0)
    }
    
    // Prueba para fallo al obtener transformaciones
    func testGetTransformationsFailure() {
        let expectation = self.expectation(description: "GetTransformationsFailure")
        
        // Simulamos un fallo en la respuesta del API
        mockClient.transformationsResult = .failure(.unknown) // Usamos Result<[Transformation], NetworkError> con fallo
        
        // Creamos un héroe simulado
        let hero = Hero(id: "1", name: "Goku", description: "", favorite: false, photo: "")
        
        // Ejecutamos el método getTransformations
        sut.getTransformations(for: hero) { result in
            switch result {
                case .success:
                    XCTFail("La obtención de transformaciones no debería haber sido exitosa")
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
