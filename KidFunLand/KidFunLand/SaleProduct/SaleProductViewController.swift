//
//  SaleProductViewController.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/8/2.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SaleProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate, UISearchBarDelegate  {
    
    

    var mySaleProductList : [APISaleProductDetail] = []
    var mySelectURL : String = ""
    var searchString : String = ""
    var userid : String = ""
    var workGroup : String = ""
    var refreshControl: UIRefreshControl!
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
        
        myTableView.delegate = self
        myTableView.dataSource = self
   
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter SomeThing....."
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        myTableView.register(UINib(nibName: "SaleProductDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SaleProductDetailTableViewCell")
        
        //let myURLString = "https://kfl.azurewebsites.net/api/MyAPI?memberId=10207020533926261&workId=desmond&all=xx"
        //configureRefreshControl()
        getAPIDataNormal()
        
    }

//    func configureRefreshControl() {
//        // 實例化 refreshControl
//        refreshControl = UIRefreshControl()
//        // 這邊因為我們有 LargeTitle 的關係，不想要讓我們讀取的 spinner 跑出來
//        // 所以我們將它透明度設置為 0
//        refreshControl.alpha = 0
//        // 這便根據 valueChanged 時來呼叫我們 getBooks 方法請求 API
//        refreshControl.addTarget(self, action: #selector(getAPIDataNormal), for: .valueChanged)
//        // 將我們的 refreshControl 加到我們 collectionView 中
//        myTableView.addSubview(refreshControl)
//    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //let myURLString =
        //getSearchBarProduct(APIstring: <#T##String#>)
    }
 
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text!

        //myTableView.reloadData()
    }
    
    func getSearchBarProduct () {
        
        userid = "10207020533926261"
        let myURLString = "https://kfl.azurewebsites.net/api/MyAPI?memberId=\(userid)&workId=desmond&all=xx"
        //APISaleProducts
        let session = URLSession.shared
        if let url = URL(string: myURLString) {
            (session.dataTask(with: url) { (data, resp, err) in
                if err == nil && data != nil {
                    let decoder = JSONDecoder()
                    do{
                        decoder.dateDecodingStrategy = .iso8601
                        let mySales = try decoder.decode(APISaleProducts.self, from: data!)
                        DispatchQueue.main.async {
                            self.mySaleProductList = mySales.Data
                            self.myTableView.reloadData()
                        }
                    }catch{
                        
                    }
                }
            }).resume()
        }
    }
    
    
    func getAPIDataNormal (){
        print("---------------------ddddd")
        userid = "10207020533926261"
        let myURLString = "https://kfl.azurewebsites.net/api/MyAPI?memberId=\(userid)&workId=desmond&all=xx"
        //APISaleProducts
        let session = URLSession.shared
        if let url = URL(string: myURLString) {
            (session.dataTask(with: url) { (data, resp, err) in
                if err == nil && data != nil {
                    let decoder = JSONDecoder()
                    do{
                        decoder.dateDecodingStrategy = .iso8601
                        let mySales = try decoder.decode(APISaleProducts.self, from: data!)
                        DispatchQueue.main.async {
                            self.mySaleProductList = mySales.Data
                            self.myTableView.reloadData()
                        }
                    }catch{
                        
                    }
                }
            }).resume()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let myString = mySaleProductList[indexPath.row].ProductLink {
            mySelectURL = myString
        }
        
        performSegue(withIdentifier: "segueSaleProductDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSaleProductDetail" {
            if let dvc = segue.destination as? WebSaleProductViewController {
                
                dvc.myLinkString = mySelectURL
                
            }
            
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySaleProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "SaleProductDetailTableViewCell", for: indexPath) as? SaleProductDetailTableViewCell
        
        
        if let myPrice = mySaleProductList[indexPath.row].ProductPrice {
            cell?.ProductPrice.text = "$\(myPrice)"
        } 
        cell?.ProductNmae.text = mySaleProductList[indexPath.row].ProductName
        if let myPic = mySaleProductList[indexPath.row].ProductPic {
            if let myURL = URL(string: myPic) {
                URLSession.shared.dataTask(with: myURL) { (data, resp, err) in
                    if let okUrl = data {
                        let download = UIImage(data: okUrl)
                        DispatchQueue.main.async {
                            cell?.ProductPic.image = download
                        }
                    }
                }.resume()
            }            
        }
        return cell ?? UITableViewCell()
    }
    
    

}
