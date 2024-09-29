//
//  DetailHeroViewController.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 24/9/24.
//

import UIKit


final class DetailHeroViewController: UIViewController {
    // Outputs
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    
    // Variables para guardar los datos que recibimos
    private let hero: Hero
    private let transformations: [Transformation]
    
    // Obtenemos los datos mediante el inicialziador
    init(hero: Hero, transformations: [Transformation]) {
        self.hero = hero
        self.transformations = transformations
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Si el contador de transformaciones = 0, ocultamos el  boton TRANSFORMATIONS
        if transformations.count == 0 {
            transformationsButton.isHidden = true
        }
        // Llamamos al metodo configureView para poner los datos del Hero que nos pasan
        configureView()
    }
    
    // En caso de pulsarse el boton TRANSFORMATIONS le pasamos las tranformations que hemos recibido y navegamos hasta el TransformationCollectionViewController
    @IBAction func didTapTransformationButton(_ sender: Any) {
        DispatchQueue.main.async {
            let transformationHero = TransformationCollectionViewController(
                hero: self.hero,
                transformations: self.transformations)
            self.navigationController?.pushViewController(transformationHero, animated: true)
        }
    }
    
}

private extension DetailHeroViewController {
    func configureView() {
        // Configuramos el nombre del Heroe
        nameLabel.text = hero.name
        // Configuramos la descripcion del Heroe
        descriptionLabel.text = hero.description
        // Verificamos que la imagen se valida
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        // COnfiguramos la imagen del heroe
        heroImage.setImage(url: imageURL)
    }
}
