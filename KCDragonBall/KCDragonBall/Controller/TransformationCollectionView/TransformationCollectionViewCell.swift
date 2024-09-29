//
//  TransformationCollectionViewCell.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 25/9/24.
//

import UIKit

class TransformationCollectionViewCell: UICollectionViewCell {
    // Conexiones
    @IBOutlet weak var transformationImageView: UIImageView!
    @IBOutlet weak var transformationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: Configuration
    func configure(with transformation: Transformation) {
        // Configuramos el nombre de la transformacion
        transformationNameLabel.text = transformation.name
        // Verificamos que la imagen sea valida
        guard let url = URL(string: transformation.photo) else {
            print("URL no válida")
            return
        }
        // Conffiguramos la imagen
        transformationImageView.setImage(url: url)
    }

}
