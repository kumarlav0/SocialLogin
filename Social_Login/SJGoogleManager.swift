//
//  SJGoogleManager.swift
//  Mazoom
//
//  Created by mac on 04/07/18.
//  Copyright © 2018 SumitJagdev. All rights reserved.
//

import UIKit
import GoogleSignIn

class SJGoogleManager: NSObject, GIDSignInDelegate {

    static let loginManager : SJGoogleManager = SJGoogleManager()
    
    var completionHandler : SJSocialCompletionHandler!
    static let CancelErrorMsg = "Google login cancelled."
    static let NoTokenErrorMsg = "Google token not found."
    static let LoginSuccessMsg = "Google login success."
    
    static func login(controller : UIViewController, completionHandler : @escaping SJSocialCompletionHandler){
        
        GIDSignIn.sharedInstance().signOut()
        SJGoogleManager.loginManager.completionHandler = completionHandler
        GIDSignIn.sharedInstance().clientID = "575346812294-1sbh7l4vtdgf93m6ro85nu9qcfo0kt2q.apps.googleusercontent.com"//"911285713331-rbo5fa16kbfmjjbbdonb7vdhep3beh10.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = SJGoogleManager.loginManager
//        GIDSignIn.sharedInstance().uiDelegate = SJGoogleManager.loginManager
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            completionHandler(false, error.localizedDescription, nil)
        } else {
            // Perform any operations on signed in user here.
            let userInfo = SJSocialUser()
            userInfo.socialType = SocialType.GOOGLE
            
            userInfo.fullName = user.profile.name
            userInfo.fName = user.profile.givenName
            userInfo.lName = user.profile.familyName
            userInfo.emailId = user.profile.email
            userInfo.socialId = user.userID
            userInfo.socialIdToken = user.authentication.idToken
            
            if self.completionHandler != nil {
                self.completionHandler(true, SJGoogleManager.LoginSuccessMsg, userInfo)
            }
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
