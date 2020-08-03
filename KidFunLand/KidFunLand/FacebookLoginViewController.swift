//
//  FacebookLoginViewController.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/7/27.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class FacebookLoginViewController: UIViewController {
    
    

    @IBOutlet weak var masterCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
//        if let token = AccessToken.current, !token.isExpired {
//            print("////////////////////////////")
//            let loginButton = FBLoginButton()
//            loginButton.center = view.center
//            view.addSubview(loginButton)
//        }
       
        
        if let accessToken = AccessToken.current {
            print("\(accessToken.userID) login")
            
            print("Done")
        }
        
        if (AccessToken.current) != nil{
            
        }
        
        
        masterCode.text = UserDefaults.standard.value(forKey: "masterCode") as? String
 
    }
  
    @IBAction func updateMasterCode(_ sender: UIButton) {
        if masterCode.text != nil {
            UserDefaults.standard.removeObject(forKey: "masterCode")
            UserDefaults.standard.set(masterCode.text, forKey: "masterCode")
        }
        let alert = UIAlertController(title: "更新完成", message: "你己成功設定代嗎", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    
    
    
    
}
