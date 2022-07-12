//
//  AppDelegate.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
      
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        let db = Firestore.firestore()
        return true
    }
}

