//
//  HeroTableViewController.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 24/9/24.
//

import UIKit

final class HeroTableViewController: UITableViewController {
    // MARK: - Table View DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Hero>
    
    // MARK: - Model
    // Creamos array de hero y lo inicializamos a vacio
    private var heroes: [Hero] = []
    private var trasformations: [Transformation] = []
    //private var transformations = [String: House]()
    // Al declarar una variable como nula, el compilador
    // infiere que su valor inicial es `nil`
    private var dataSource: DataSource?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista de heroes"
        // 1. Registrar la celda custom
        // Registramos la celda que hemos creado de forma personalizada
        tableView.register(
            // Instanciamos el archivo .xib a traves de su nombre
            UINib(nibName: HeroTableViewCell.identifier, bundle: nil),
            // Cada vez que TableView se encuentre este identificador
            // tiene que instanciar el .xib que le especificamos
            forCellReuseIdentifier: HeroTableViewCell.identifier
        )
        // 2. Configuramos el data source
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, hero in
            // Obtenemos una celda reusable y la casteamos a
            // el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeroTableViewCell.identifier,
                for: indexPath
            ) as? HeroTableViewCell else {
                // Si no podemos desempaquetarla
                // retornamos una celda en blanco
                return UITableViewCell()
            }
            cell.configure(with: hero)
            return cell
        }
        
        // 3. Añadimos el data source al table view
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        // 4. Crear un snapshot con los objetos a representar
        var snapshot = Snapshot()
        // Obtenemos la lista de Heroes
        NetworkModel.shared.getHeroes { result in
            switch result {
                case let .success(heroes):
                    DispatchQueue.main.async {
                        print("Heroes: \(heroes)")
                        self.heroes = heroes
                        // Añadimos los objetos a rerpesentar
                        snapshot.appendSections([0])
                        snapshot.appendItems(heroes)
                        // Aplicamos el SnapShot
                        self.dataSource?.apply(snapshot)
                        
                    }
                // En caso de error se muestra una ventana de erro
                case let .failure(error):
                    print("Error: \(error)")
                    DispatchQueue.main.async {
                        // En caso de fallo, mostramos un mensaje de error
                        let alert = UIAlertController(title: "Error", message: "No se pudo obtener la lista de héroes", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
            }
        }
    }
    
}

// Ajustes sobrel el TableView
extension HeroTableViewController {
    // COnfiguramos el tamaño de las celdas
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {100}

    // Mediante el metodo delegado, detectamos si se ha pulsado una celda
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // Obtenemos el Heroe asociado a la celda pulsada
        let hero = heroes[indexPath.row]
        // Obtenemos las transformaciones de haberlas asociadas al Heroe seleccioado
        NetworkModel.shared.getTransformations(for: hero) { result in
            switch result {
                case let .success(trasformations):
                    DispatchQueue.main.async {
                        print("Transformations: \(trasformations)")
                        // Las trasnsformaciones obtenidas se almacenan
                        self.trasformations = trasformations
                        // Ordenamos el array transformations según el número al inicio de name
                        self.trasformations.sort { extractLeadingNumber(from: $0.name) < extractLeadingNumber(from: $1.name) }
                        // Instanciamos DetailHeroViewController y navegamos hacia él y le pasamos el Heroe seleccionado y sus transformaciones
                        DispatchQueue.main.async {
                            let detailHero = DetailHeroViewController(
                                hero: hero,
                                transformations: self.trasformations)//trasformations)
                            self.navigationController?.pushViewController(detailHero, animated: true)
                        }
                        
                    }
                // En caso de error, mostramos ventana con mensaje de error
                case let .failure(error):
                    print("Error: \(error)")
                    DispatchQueue.main.async {
                        // En caso de fallo, mostramos un mensaje de error
                        let alert = UIAlertController(title: "Error", message: "No se pudo obtener la lista de transformaciones", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
            }
        }
        
        print("Click en celda \(hero.name)")
        //navigationController?.show(detailViewController, sender: self)
    }
}

