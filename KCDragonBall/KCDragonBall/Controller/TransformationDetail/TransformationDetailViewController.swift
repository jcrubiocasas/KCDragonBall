//
//  TransformationDetailViewController.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 25/9/24.
//

import UIKit

class TransformationDetailViewController: UIViewController {
    @IBOutlet weak var transformationImage: UIImageView!
    @IBOutlet weak var transformationNameLabel: UILabel!
    @IBOutlet weak var transformationDescriptionLabel: UILabel!
    
    // Variable para guardar la transformacion
    private let transformation: Transformation
    // Inicializador desde el que recibimos los datos
    init(transformation: Transformation) {
        self.transformation = transformation
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

private extension TransformationDetailViewController {
    func configureView() {
        // COnfiguramos el nombre de la transformacion
        transformationNameLabel.text = transformation.name
        // Configuramos la descripcion de la transformacion
        transformationDescriptionLabel.text = transformation.description
        // Verificamos que la imagen sea valida
        guard let imageURL = URL(string: transformation.photo) else {
            return
        }
        // COnfiguramos la imagen de la transformacion
        transformationImage.setImage(url: imageURL)
    }

}
