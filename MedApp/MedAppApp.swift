//
//  MedAppApp.swift
//  MedApp
//
//  Created by mateus oliveira on 08/11/20.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Combine
import FirebaseCore
import UIKit

@main
struct MedApp: App{
    // Attaching app delegate to swiftui
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    var body: some Scene{
        WindowGroup{
            //PAssign to main view
            ContentView()
        }
    }
}

// To observe or read data from AppDelegate



class Delegate: NSObject, UIApplicationDelegate, GIDSignInDelegate, ObservableObject {
    
    @Published var email = ""
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
     
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let user = user else{
            print(error.localizedDescription)
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
   
        // Signin in to Firebase
        Auth.auth().signIn(with: credential) { (result, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            self.email = (result?.user.email)!
            print(result?.user.email as Any)
        }
    }
    
}


