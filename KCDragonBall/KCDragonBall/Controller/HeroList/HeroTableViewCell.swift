//
//  HeroTableViewCell.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 24/9/24.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    //MARK: Identifier
    // Usando String(describing:) vamos a crear un String
    // de la siguiente forma "HouseTableViewCell"
    // static let identifier = "HouseTableViewCell"
    static let identifier = String(describing: HeroTableViewCell.self)
    
    //MARK: Outlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    //@IBOutlet weak var heroDescriptionLabel: UILabel!
    
    //MARK: Configuration
    func configure(with hero: Hero) {
        // Ponemos el nombre del Heroe
        heroNameLabel.text = hero.name
        // Verificamos que la imagen sea valida
        guard let url = URL(string: hero.photo) else {
            print("URL no válida")
            return
        }
        // Ponemos la imagen valida
        heroImage.setImage(url: url)
    }
}
