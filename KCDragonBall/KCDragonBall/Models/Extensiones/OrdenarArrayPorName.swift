//
//  OrdenarArrayPorName.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 25/9/24.
//

import Foundation

// Función que extrae el número al inicio de una cadena
func extractLeadingNumber(from name: String) -> Int {
    // Divide la cadena en partes usando espacios como separador
    // Por ejemplo, "1. Oozaru – Gran Mono" se convierte en ["1.", "Oozaru", "–", "Gran", "Mono"]
    let components = name.split(separator: " ")
    // Intenta obtener el primer componente de la cadena (en este caso, debería ser el número seguido de un punto)
    // Si la cadena está vacía o no tiene espacios, components.first será nil
    if let firstComponent = components.first,
       // Reemplaza el punto final del número (por ejemplo, "1." se convierte en "1")
       // Luego, intenta convertir esa cadena a un número entero
        let number = Int(firstComponent.replacingOccurrences(of: ".", with: "")) {
       // Si la conversión a número entero es exitosa, devuelve ese número
        return number
    }
    // Si no se encuentra un número válido, devuelve Int.max
    // Esto asegura que cadenas sin número vayan al final cuando se ordenen
    return Int.max
}
