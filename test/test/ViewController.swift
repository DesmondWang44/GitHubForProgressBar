//
//  ViewController.swift
//  test
//
//  Created by WANG YAO-KUAN on 2020/7/18.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit


class ViewController: UITableViewController, UISearchResultsUpdating {
    let appleProduct = ["Apple TV", "Apple Watch", "iMac", "iPhone", "Macbook Pro", "iPad", "iPod", "Air Pod"]
    
    let searchResultsController = UITableViewController()
    var searchcontroller:UISearchController?
    var resultArray = [String]()
    
    @IBOutlet var myTableView: UITableView!
    override func viewDidLoad() {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        searchcontroller = UISearchController(searchResultsController: searchResultsController)
        tableView.tableHeaderView = searchcontroller?.searchBar
        searchcontroller?.searchResultsUpdater = self
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchWord = searchcontroller?.searchBar.text{
            resultArray = appleProduct.filter({
                (thisProduct) -> Bool in
                if thisProduct.lowercased().contains(searchWord.lowercased()){
                    return true
                }else{
                    return false
                }
            })
            self.searchResultsController.tableView.reloadData()
        }
    }
    
    //MARK:Table View Method
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return appleProduct.count
        }else{
            return resultArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == self.tableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = appleProduct[indexPath.row]
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = resultArray[indexPath.row]
            return cell
        }
    }
    
}

