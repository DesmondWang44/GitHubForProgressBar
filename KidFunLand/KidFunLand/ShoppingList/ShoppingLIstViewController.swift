//
//  ShoppingLIstViewController.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/7/26.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ShoppingLIstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    
    
    var myShoppingList : [ShoppingLIst] = []
    var myAPIProductDetail : [APIProductDetail] = [];
    var userid : String = ""
    
    @IBOutlet weak var myTable: UITableView!
    
    var session = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Error", message: "請登入Facebook帳號,並且輸入團購主代碼", preferredStyle: .alert)
        let action = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        alert.addAction(action)
        if checkLoginStuff() == false {
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        myTable.delegate = self
        myTable.dataSource = self
       
        
        myTable.register(UINib(nibName: "ShoppingLIstTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ShoppingLIstTableViewCell")
        //let myURLString = "https://kfl.azurewebsites.net/api/MyAPI?memberId=10207020533926261&workId=desmond&plist=fef"
        
        getAPIDataNormal()
    
    }
    
  
    func getAPIDataNormal () {
        userid = "10207020533926261"
        let myURLString = "https://kfl.azurewebsites.net/api/MyAPI?memberId=\(userid)&workId=desmond&plist=fef"
        let session = URLSession.shared
        if let url = URL(string: myURLString) {
            guard url != nil else {
                return
            }
            let dataTask = session.dataTask(with: url, completionHandler: { (data, respond, error) in
                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    do{
                        //日期格式
                        decoder.dateDecodingStrategy = .iso8601
                        let myProduct = try decoder.decode(APIProduct.self, from: data!)
                        self.myAPIProductDetail = myProduct.Data ?? []
                        DispatchQueue.main.async {
                            self.myTable.reloadData()
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            })
            dataTask.resume()
        }
        
        
    }
    
   
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myShoppingList.count
        return myAPIProductDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "ShoppingLIstTableViewCell", for: indexPath) as? ShoppingLIstTableViewCell
        
        
        
        cell?.productName.text = myAPIProductDetail[indexPath.row].ProductName
        if let myPrice = myAPIProductDetail[indexPath.row].ProductPrice {
            cell?.productPrice.text = "金額：\(myPrice)"
        }
        if let myQTY = myAPIProductDetail[indexPath.row].QTY {
            cell?.productQTY.text = "數量：\(myQTY)"
        }
        if myAPIProductDetail[indexPath.row].IsArrive == "N" {
            cell?.isArriveLabel.text = "未到貨"
        } else {
            cell?.isArriveLabel.text = "己到貨"
        }
        if myAPIProductDetail[indexPath.row].IsTake == "N" {
            cell?.isTakeLabel.text = "未取貨"
        } else {
            cell?.isTakeLabel.text = "己取貨"
        }
        if myAPIProductDetail[indexPath.row].IsPay == "3P1" {
            cell?.isPayLabel.text = "未付款"
        } else {
            cell?.isPayLabel.text = "己付款"
        }
        
//        let myImage = UIImage(named: "cat1.jpg")
//        cell?.productPic.image = myImage
//
        if let myPic = myAPIProductDetail[indexPath.row].Image {
            if let myURL = URL(string: myPic) {
                URLSession.shared.dataTask(with: myURL) { (data, resp, err) in
                    if let okUrl = data {
                        let download = UIImage(data: okUrl)
                        DispatchQueue.main.async {
                            cell?.productPic.image = download
                        }
                    } else {
                       
                    }
                }.resume()
            }
        }
        return cell ?? UITableViewCell()
    }
    
    

}

class ShoppingLIst  {
    var name = ""
    var price = ""
    var isPay = false
    var isArrive = false
    var isTake = false
    var pic = "URL"

 
}
