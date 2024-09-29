//
//  SceneDelegate.swift
//  KCDragonBall
//
//  Created by Juan Carlos Rubio Casas on 23/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            // Asegurarte de que tienes un objeto UIWindowScene
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            // Crear una instancia de UIWindow usando el windowScene
            let window = UIWindow(windowScene: windowScene)
            
            // Cargar la pantalla de login desde el archivo XIB
            let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            
            // Asignar el controlador de vista de login como la raíz de la ventana
            window.rootViewController = UINavigationController(rootViewController: loginViewController)
            
            // Hacer la ventana visible
            self.window = window
            window.makeKeyAndVisible()
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

