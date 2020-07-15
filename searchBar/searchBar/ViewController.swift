//
//  ViewController.swift
//  searchBar
//
//  Created by WANG YAO-KUAN on 2020/7/15.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit

var myProduct = ["MacPro","Ps4","xBoxOne","iWatch","Apple"]

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    let searchResultsController = UITableViewController()
    var searchcontroller : UISearchController?
    var resultArray = [String]()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        searchcontroller = UISearchController(searchResultsController: searchResultsController)
        myTableView.tableHeaderView = searchcontroller?.searchBar
        searchcontroller?.searchResultsUpdater = self
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.delegate = self
        
        searchResultsController.tableView.register(searchBarTableViewCell.self, forCellReuseIdentifier: "mySearchID")
        
        
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchWord =  searchcontroller?.searchBar.text {
            resultArray = myProduct.filter({
                (findProduct) -> Bool in
                if findProduct.lowercased().contains(searchWord.lowercased()){
                    return true
                } else {
                    return false
                }
            })
            self.searchResultsController.tableView.reloadData()
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.myTableView {
            return myProduct.count
        } else {
            return resultArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == myTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? searchBarTableViewCell {
                for _ in myProduct {
                    cell.myNameLabel.text = myProduct[indexPath.row]
                }
                return cell
            } else {
                let cell = UITableViewCell()
                return cell
            }
        }else {
            
            print("是否有進入 ")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mySearchID", for: indexPath) as? searchBarTableViewCell {
                
               
                for _ in resultArray {
                    print("cell.myNameLabel.text   is  nil ?????????")
                    cell.myNameLabel.text = resultArray[indexPath.row]
                }
                return cell
            } else {
                let cell = UITableViewCell()
                return cell
            }
            
            
            
            
        }
        
        
        
        
    }

}

