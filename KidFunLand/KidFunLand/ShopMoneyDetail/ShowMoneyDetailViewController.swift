//
//  ShowMoneyDetailViewController.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/7/28.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ShowMoneyDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var myShoppingList : [ShoppingLIst] = []
    var myAPIMoneyDetail : [APIShopMoneyDetail] = []
    var setRestOfMoney : Float = 0
    var userid : String = ""
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let alert = UIAlertController(title: "Error", message: "請登入Facebook帳號,並且輸入團購主代碼", preferredStyle: .alert)
        let action = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        alert.addAction(action)
        if checkLoginStuff() == false {
            present(alert, animated: true, completion: nil)
            return
        }
        
        myTableView.register(UINib(nibName: "SetDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SetDetailTableViewCell")
        myTableView.register(UINib(nibName: "RoofDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "RoofDetailTableViewCell")
        
        myTableView.delegate = self
        myTableView.dataSource = self
      
        //let myURLString = "https://kfl.azurewebsites.net/api/MyAPI?memberId=10207020533926261&workId=desmond&mlist=fff"
        
        getAPIDataNormal()
        
    }
    
    func getAPIDataNormal () {
        userid = "10207020533926261"
        let myURLString = "https://kfl.azurewebsites.net/api/MyAPI?memberId=\(userid)&workId=desmond&mlist=fff"
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
                        let myMoney = try decoder.decode(APIShopMoney.self, from: data!)
                        self.setRestOfMoney = myMoney.RestOfShopMoney
                        self.myAPIMoneyDetail = myMoney.Data
                        DispatchQueue.main.async {
                            
                            self.myTableView.reloadData()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return myAPIMoneyDetail.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = myTableView.dequeueReusableCell(withIdentifier: "RoofDetailTableViewCell", for: indexPath) as? RoofDetailTableViewCell {
                cell.shopMoneyLeftLabel.text = "購物金餘額：\(setRestOfMoney)"
                return cell
            }
            
            return UITableViewCell()
        } else if indexPath.section == 1 {
            let cell = myTableView.dequeueReusableCell(withIdentifier: "SetDetailTableViewCell", for: indexPath) as? SetDetailTableViewCell
            
            
            if let myIO = myAPIMoneyDetail[indexPath.row].IOKind {
                if myIO == "1" {
                    let myImage = UIImage(systemName: "plus.app")
                    myImage?.withTintColor(.green)
                    cell?.IOStatsImage.image = myImage
                } else if myIO == "2" {
                    let myImage = UIImage(systemName: "minus.square")
                    myImage?.withTintColor(.red)
                    myImage?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                    cell?.IOStatsImage.image = myImage
                }
                
            }
            if let mySys = myAPIMoneyDetail[indexPath.row].SysRemark {
                cell?.sysRemarkLabel.text =  "系統備註:\(mySys)"
            }
            if let myMoney = myAPIMoneyDetail[indexPath.row].HPay {
                cell?.moneyLabel.text = "異動金額：\(String(describing: myMoney))"
            }
            
            cell?.moneyDateLabel.text = myAPIMoneyDetail[indexPath.row].SetData
            
            
            return cell ?? UITableViewCell()
            
        } else {
            return UITableViewCell()
        }
        
        
    }
}
