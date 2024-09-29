//
//  test_reproductor.swift
//  KCDragonBallTests
//
//  Created by Juan Carlos Rubio Casas on 28/9/24.
//

import XCTest
@testable import KCDragonBall

final class AudioPlayerTests: XCTestCase {
    
    var sut: AudioPlayer! // System Under Test (sut)
    
    override func setUp() {
        super.setUp()
        // Se inicializa el AudioPlayer
        sut = AudioPlayer()
    }
    
    override func tearDown() {
        // Se libera la memoria asignada al AudioPlayer
        sut = nil
        super.tearDown()
    }
    
    // Prueba para el método playMusic
    func testPlayMusic() {
        // Ejecutamos el método playMusic
        sut.playMusic()
        
        // Verificamos que el audioPlayer se ha inicializado correctamente
        XCTAssertNotNil(sut.audioPlayer)
    }
    
    // Prueba para el método stopMusic
    func testStopMusic() {
        // Primero hacemos que la música empiece a reproducirse
        sut.playMusic()
        // Ejecutamos el método stopMusic
        sut.stopMusic()
        
        // Verificamos que el audioPlayer se haya detenido y sea nil
        XCTAssertNil(sut.audioPlayer)
    }
}
