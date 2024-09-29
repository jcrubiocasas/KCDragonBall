//
//  TransformationCollectionViewController.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 25/9/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class TransformationCollectionViewController: UICollectionViewController {
    
    // Variables para guardar los datos que recibimos
    private let hero: Hero
    private let transformations: [Transformation]
    // Obtenemos los datos mediante el inicialziador
    init(hero: Hero,
         transformations: [Transformation],
         layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.hero = hero
        self.transformations = transformations
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Establecemos el titulo
        self.title = "Transformaciones de \(hero.name)"
        self.collectionView.tintColor = .yellow
        // Establecesmos el color de fondo
        self.collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TransformationCollectionViewCell")
        // Registrar la celda personalizada
        collectionView.register(
            UINib(nibName: "TransformationCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier)
        // Configuramos el layout para que sea una columna de celdas
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            // Verificamos si el layout de la colección es del tipo UICollectionViewFlowLayout.
            // Esto es importante porque queremos asegurarnos de que el layout sea un flow layout,
            // que organiza las celdas en filas o columnas y permite configurar el tamaño y el espaciado.
            let padding: CGFloat = 0
            // Definimos el valor de "padding" como 0 puntos. Este valor se utilizará como
            // margen (espacio) en los lados izquierdo y derecho de cada celda.
            let itemWidth = collectionView.frame.width - 2 * padding
            // Calculamos el ancho de cada celda restando el doble del padding (para los lados izquierdo y derecho)
            // del ancho total de la `collectionView`. Esto asegura que la celda ocupe todo el espacio disponible,
            // dejando un margen (padding) de 32 puntos a ambos lados.
            layout.itemSize = CGSize(width: itemWidth, height: 120)
            // Asignamos el tamaño de cada celda usando las dimensiones calculadas.
            // El ancho de la celda es el que calculamos (itemWidth) y la altura es fija, en este caso 120 puntos.
            layout.sectionInset = UIEdgeInsets(top: 10, left: padding, bottom: 10, right: padding)
            // Configuramos los márgenes para la sección utilizando `UIEdgeInsets`.
            // Aquí estamos añadiendo un espacio de 10 puntos en la parte superior e inferior de la sección
            // y el padding que definimos (32 puntos) en los lados izquierdo y derecho.
            layout.minimumLineSpacing = 10
            // Establecemos el espaciado mínimo entre las líneas (es decir, entre las filas de celdas).
            // En este caso, dejamos un espacio de 10 puntos entre cada fila de celdas.
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        transformations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            // Desencolamos la celda personalizada
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TransformationCollectionViewCell else {
                fatalError("Error al dequeuer la celda TransformationCollectionViewCell")
            }
            // Configuramos la celda con la transformación correspondiente
            let transformation = transformations[indexPath.item]
            cell.configure(with: transformation)
            return cell
        }
   
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Aquí obtenemos el índice de la celda seleccionada
        let selectedTransformation = transformations[indexPath.item]
        
        // Registramos la transformación seleccionada
        print("Celda seleccionada: \(selectedTransformation.name)")
        // Si quieres deseleccionar la celda después de seleccionarla ¿?¿?¿? No usar
        //collectionView.deselectItem(at: indexPath, animated: true)
        
        // Navegamos a detalle de transformacion TransformationDetailViewController y le pasamos la transformacion
        DispatchQueue.main.async {
            let transformationDetail = TransformationDetailViewController(
                transformation: self.transformations[indexPath.item])
            self.navigationController?.pushViewController(transformationDetail, animated: true)
        }
    }
/*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}
