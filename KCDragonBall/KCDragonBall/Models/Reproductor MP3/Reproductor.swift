//
//  Reproductor.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 24/9/24.
//
import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    
    func playMusic() {
        // Se configura reproducción continua
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error al configurar la sesión de audio: \(error.localizedDescription)")
            return
        }
        // El archivo tiene que estar en la misma ruta
        guard let url = Bundle.main.url(
            forResource: "DragonBall", // Ruta y archivo
            withExtension: "mp3") else {
            print("No se encontró el archivo DragonBall.mp3")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url) // Se instancia el reproductor con el archivo
            audioPlayer?.prepareToPlay() // Se prepara la ejecucion
            audioPlayer?.numberOfLoops = -1 // Se configura la repeticion infinita
            audioPlayer?.play() // Se reproduce
            
            print("Reproduciendo música...") // Se registra la reproduccion de musica para depurar
        } catch let error {
            print("Error al reproducir música: \(error.localizedDescription)")
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop() // Se detien el reproducto
        audioPlayer = nil // Se libera el reproducto
        print("Música detenida.") // Se registra para depurar
    }
}
