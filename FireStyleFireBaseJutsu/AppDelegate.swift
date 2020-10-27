//
//  AppDelegate.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/27/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Foundation
import UIKit
import Firebase
// import GoogleSignIn

import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate { //  GIDSignInDelegate
    
    var ref: DatabaseReference! // ref = Database.database().reference() - do this later
    
    // MARK: - Google sign in protocol methods
    
    // MARS: - Getting Google user's profile info
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//      if let error = error {
//        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//          print("The user has not signed in before or they have since signed out.")
//        } else {
//          print("\(error.localizedDescription)")
//        }
//        return
//      }
//      // Perform any operations on signed in user here.
//      let userId = user.userID                  // For client-side use only!
//      let idToken = user.authentication.idToken // Safe to send to the server
//      let fullName = user.profile.name
//      let givenName = user.profile.givenName
//      let familyName = user.profile.familyName
//      let email = user.profile.email
//
//      print([userId, idToken, fullName, givenName, familyName, email])
//        // simply to get rid of the warning haha
//
//      let img = user.profile.imageURL(withDimension: 150)
//
//        // https://lh3.googleusercontent.com/a-/AOh14GjjDCFrcm_e7wOPN70JtTNET_CFHDayFRSzOBhCtw=s96-c
//        // my profile pic for yren
//
//        // MARK: -
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "signin"), object: nil, userInfo: ["user": user])
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewcontroller"), object: nil, userInfo: ["user":user])
//
//
////        self.ref.child("users").setValue(["userId": user.userID])
////        self.ref.child("users").child(user.userID).setValue(["userId": user.userID])
//
//    }
    
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//              withError error: Error!) {
//      // Perform any operations when the user disconnects from app here.
//      // ...
//    }
    // is this one necessary though?
    
    
//    @available(iOS 9.0, *)
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url)
//    }
//
//    func application(_ application: UIApplication,
//                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url)
//    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // MARS: - Database part
        ref = Database.database().reference()
        
        // MARS: - Google sign in part
        
   //     GIDSignIn.sharedInstance().clientID = "943009449310-59gnroclfji4fuukkrha5t34pjnpqcj7.apps.googleusercontent.com"

 //       GIDSignIn.sharedInstance().delegate = self

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

