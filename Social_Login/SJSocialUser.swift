//
//  SJSocialUser.swift
//  SJSocialManager
//
//  Created by mac on 14/09/17.
//  Copyright © 2017 SumitJagdev. All rights reserved.
//

import UIKit

enum SocialType {
    case FACEBOOK
    case TWITTER
    case INSTAGRAM
    case GOOGLE
}

class SJSocialUser: NSObject {

    var socialType : SocialType!
    
    var socialIdToken : String!
    var socialId : String!
    var fName : String!
    var lName : String!
    var fullName : String!
    var gender : String!
    var emailId : String!
    var imageURL : String!
    
    
    //MARK: KeyFor Facebook Information
    static func createUserWithFacebook(data: NSDictionary) -> SJSocialUser {
        let user = SJSocialUser()
        user.socialType = SocialType.FACEBOOK

        user.fullName = data.value(forKey: "name") as! String?
        user.fName = data.value(forKey: "first_name") as! String?
        user.lName = data.value(forKey: "last_name") as! String?
        user.emailId = data.value(forKey: "email") as! String?
        user.gender = data.value(forKey: "gender") as! String?
        user.socialId = data.value(forKey: "id") as! String?
        if let picture = data.value(forKey: "picture") as? NSDictionary {
            if let data = picture.value(forKey: "data") as? NSDictionary {
                if let url = data.value(forKey: "url") as? String {
                   user.imageURL = url
                }
            }
        }
        
        
        return user
    }
    
   //MARK: KeyFor Twitter Information
    static func createUserWithTwitter(data: NSDictionary) -> SJSocialUser {
        let user = SJSocialUser()
        user.socialType = SocialType.TWITTER
        
        user.socialId = ""
        user.fName = ""
        user.lName = ""
        user.fullName = ""
        user.emailId = ""
        user.imageURL = ""
        
        return user
    }
    
    //MARK: KeyFor Instagram Information
    static func createUserWithInstagram(data: NSDictionary) -> SJSocialUser {
        let user = SJSocialUser()
        user.socialType = SocialType.INSTAGRAM
        
        user.fullName = data.value(forKey: "full_name") as! String?
        user.fName = data.value(forKey: "username") as! String?
        user.imageURL = data.value(forKey: "profile_picture") as! String?
        user.socialId = data.value(forKey: "id") as! String?
        
        return user
    }
    
}

////MARK: KeyFor Facebook Information
//extension SJSocialUser {
//    static let kFacebookUserId : String = ""
//    static let kFacebookFirstName : String = ""
//    static let kFacebookLastName : String = ""
//    static let kFacebookEMail : String = ""
//    static let kFacebookProfilePickURL : String = ""
//}
//
////MARK: KeyFor Twitter Information
//extension SJSocialUser {
//    static let kTwitterUserId : String = ""
//    static let kTwitterFirstName : String = ""
//    static let kTwitterLastName : String = ""
//    static let kTwitterEMail : String = ""
//    static let kTwitterProfilePickURL : String = ""
//}
//
////MARK: KeyFor Instagram Information
//extension SJSocialUser {
//    static let kInstagramUserId : String = ""
//    static let kInstagramFirstName : String = ""
//    static let kInstagramLastName : String = ""
//    static let kInstagramEMail : String = ""
//    static let kInstagramProfilePickURL : String = ""
//}

