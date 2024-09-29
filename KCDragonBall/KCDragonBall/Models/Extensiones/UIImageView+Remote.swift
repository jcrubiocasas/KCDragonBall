//
//  UIImageView+Remote.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 24/9/24.
//

import UIKit

extension UIImageView {
    func setImage(url: URL) {
        // Capturamos self para no crear dependencias circulares
        downloadWithURLSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    // Este metodo obtiene una imagen a partir de una URL con URLSession
    private func downloadWithURLSession(
        url: URL,
        completion: @escaping (UIImage?) -> Void
    ) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
            guard let data, let image = UIImage(data: data) else {
                // No puedo desempaquetar data ni la imagen
                // llamo al completion con nil
                completion(nil)
                return
            }
            completion(image)
        }
        .resume()
    }
}
/*
extension UIImageView {
    func loadImage(from urlString: String) {
        // Verificamos que la URL es válida
        guard let url = URL(string: urlString) else {
            print("URL no válida")
            return
        }
        
        // Realizamos la descarga de la imagen en segundo plano
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Verificamos si hay errores
            if let error = error {
                print("Error al descargar la imagen: \(error)")
                return
            }
            
            // Verificamos que los datos existan y sean válidos
            guard let data = data, let image = UIImage(data: data) else {
                print("No se pudieron obtener los datos de la imagen")
                return
            }
            
            // Actualizamos la UI en el hilo principal
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume() // Iniciamos la tarea de descarga
    }
}
*/
