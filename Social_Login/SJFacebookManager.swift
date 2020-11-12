//
//  SJFacebookManager.swift
//  SJSocialManager
//
//  Created by mac on 18/05/19.
//  Copyright © 2017 Sujeet. All rights reserved.
//


import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

typealias SJSocialCompletionHandler = (_ isSuccess: Bool, _ msg: String?, _ userObject: SJSocialUser?)->Void



class SJFacebookManager: NSObject {

    static let CancelErrorMsg = "Facebook login cancelled."
    static let NoTokenErrorMsg = "Facebook token not found."
    static let LoginSuccessMsg = "Facebook login success."
    
    #if DEBUG
    
    #endif
    
    static func login(controller : UIViewController, completionHandler : @escaping SJSocialCompletionHandler){
        
        let loginManager : LoginManager = LoginManager()
        loginManager .logOut()
        AccessToken.current = nil
        Profile.current = nil
      
        loginManager .logIn(permissions: ["public_profile", "email", "user_friends"], from: controller) { (result, error) in
            
            if error != nil {
                completionHandler(false, error?.localizedDescription, nil)
            }else if result?.isCancelled == true {
                completionHandler(false, SJFacebookManager.CancelErrorMsg, nil)
            }else{
                if AccessToken.current != nil {
                    // Use <userData> or create new one?
                    var params = NSMutableDictionary() as NSDictionary? as? [AnyHashable: Any] ?? [:]
                    
                    // Set base properties
                    params["fields"] = "first_name, last_name, picture.type(large), email, name, id, gender"
                    let request : GraphRequest = GraphRequest(graphPath: "me", parameters:params as! [String : Any])
                    request.start(completionHandler: { (requestConnection, graphResult, graphError) in
                        
                        if result != nil {
                            loginManager .logOut()
                            let user = SJSocialUser.createUserWithFacebook(data: graphResult as! NSDictionary)
                            completionHandler(true, SJFacebookManager.LoginSuccessMsg, user)
                        }else{
                            completionHandler(false, graphError?.localizedDescription, nil)
                        }
                    })
                    
                }else{
                    completionHandler(false, SJFacebookManager.NoTokenErrorMsg, nil)
                }
            }
        }
    }
}




/**
 
 // Facebook Login
 import FBSDKLoginKit
 import FBSDKCoreKit

 
 
 
 @IBAction func facebookLoginButtonTapped(_ sender: Any) {
       print(".................")
       SJFacebookManager.login(controller: self) { (isSuccess, msg, user) in
           debugPrint(msg!)
           if user != nil {
               debugPrint("User Name : ", user?.fullName! ?? "Not Found")
               self.loginViewModel.login(isLoaderEnable: true, number: user!.emailId, password: user!.socialId, sourceType: "Facebook", idSocial: user!.socialId)
           }
       }
   }
 
 
 
 */
