//
//  LoginViewController.swift
//  DragonBall
//
//  Created by Juan Carlos Rubio Casas on 20/9/24.
//

import UIKit


class LoginViewController: UIViewController {
    // Conexiones con objetos en pantalla
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Desactiva el bloqueo de pantalla automático mientras se ejecute la aplicacion
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    // Se pulsa el boton loginButton
    @IBAction func didTapLogin(_ sender: Any) {
        // Creamos las constantes email y password con valores no nil
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // En caso de no introducir email y/o password, se muestra mensaje de error
            let alert = UIAlertController(
                title: "Datos insuficientes",
                message: "Introduzca EMAIL y PASSWORD",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default))
            self.present(alert,animated: true)
            return
        }
        // Hacemos login con NetworkModel
        NetworkModel.shared.login(user: email, password: password) { result in
            switch result {
                // En caso OK cargamos la lista de heroes
                case let .success(token):
                    // En caso de login exitodo comenzamos la reproduccion de DragonBall.mp3
                    NetworkModel.shared.playMusic()
                    print("Token: \(token)")
                    // Instanciamos HeroTableViewController y navegamos hacia él
                    DispatchQueue.main.async {
                        let heroListVC = HeroTableViewController()
                        self.navigationController?.setViewControllers([heroListVC], animated: true)
                    }
                // En caso de error
                case let .failure(error):
                    // Imprimimos error
                    print("Error: \(error)")
                    // Mostramos ventana emergente, indicando que las credenciales son incorrectas
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Credenciales incorrectas", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                }
            }
        }
    }
}
