//
//   ProgramMethod.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/8/3.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//
import UIKit
import FBSDKLoginKit

func checkLoginStuff () -> Bool {
    
    
    
    
    if let accessToken = AccessToken.current {
        //userid = accessToken.userID
    } else {
        
        return false
    }
    if UserDefaults.standard.value(forKey: "masterCode") != nil {
        //workGroup = UserDefaults.standard.value(forKey: "masterCode") as? String ?? ""
    } else {
        return false
    }
          
    
    return true
}
