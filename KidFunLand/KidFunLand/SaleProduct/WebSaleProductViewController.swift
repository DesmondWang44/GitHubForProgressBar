//
//  WebSaleProductViewController.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/8/3.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit
import WebKit


class WebSaleProductViewController: UIViewController {

    var myLinkString : String = ""
    
    @IBOutlet weak var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("=====================================\(myLinkString)"  )
        let myString = myLinkString
        if let myURL = URL(string: myString) {
            let myRequest = URLRequest(url: myURL)
            myWebView.load(myRequest)
        }
        
      
    }
    

    
}
