//
//  Hero.swift
//  KCDragonBall
//
//  Created by Adrián Silva on 23/9/24.
//

import Foundation

struct Hero: Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let favorite: Bool
    let photo: String    
}
