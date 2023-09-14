//
//  AppDelegate.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 02.06.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window {
//            let navigationController = UINavigationController()
//            let loggedOutViewController = LoggedOutViewController()
//            navigationController.viewControllers = [loggedOutViewController]
            window.rootViewController = RootViewController()
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

