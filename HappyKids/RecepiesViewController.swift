//
//  RecepiesViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 2/24/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography
import SwiftSpinner


class RecepiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var search = UISearchController(searchResultsController: nil)
    var tableView: UITableView = UITableView()
    var food = [Recepies]()
    var backendless = Backendless.sharedInstance()
    var searchedFood = [Recepies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.red
        self.title = "recepies"
        SwiftSpinner.show("Connecting...")
        self.findFoodAssync()
        SwiftSpinner.hide()
        //self.addToArray()
        search.searchResultsUpdater = self
        search.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = search.searchBar
        self.createView()
        
    }
    func findFoodAssync(){
        SwiftSpinner.show("Connecting...")
        let dataStore = backendless?.data.of(Recepies.ofClass())
        var error: Fault?
        let result = dataStore?.find(&error)
        if error == nil {
            let foods = result?.getCurrentPage()
            guard let fs = foods else{
                return
            }
            for obj in fs {
                food.append(obj as! Recepies)
            }
            SwiftSpinner.hide()
            
        }else{
            SwiftSpinner.hide()
            
            print("Server reported an error: \(error)")
        }
    }
    func createView(){
        view.addSubview(tableView)
        constrain(view, tableView){
            view, tableView in
            tableView.top == view.top
            //tableView.centerX == view.centerX
            tableView.width == view.width
            tableView.right == view.right
            tableView.bottom == view.bottom
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if search.isActive && search.searchBar.text != ""{
            return self.searchedFood.count
        }
        
        return self.food.count
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let name: String!
        let ph: String!
        let cell = MyTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if search.isActive && search.searchBar.text != ""{
            name = self.searchedFood[(indexPath as NSIndexPath).item].name
            // ch = self.searchedChallanges[(indexPath as NSIndexPath).item]
            // ur = self.searchedChallanges[(indexPath as NSIndexPath).item].imageRef
            ph = self.searchedFood[(indexPath as NSIndexPath).item].pic
        }else{
            name = self.food[(indexPath as NSIndexPath).item].name
            // ch = self.challanges[(indexPath as NSIndexPath).item]
            // ur = self.challanges[(indexPath as NSIndexPath).item].imageRef
            ph = self.food[(indexPath as NSIndexPath).item].pic
        }
        cell.name = name
       // cell.textLabel?.text = name
        do{
            // try cell.imageView?.image = UIImage(data: Data(contentsOf: URL(fileURLWithPath: ph)))
            let url = URL(string: ph)
            let data = try Data(contentsOf: url!)
            cell.img = UIImage(data: data)
           // cell.imageView?.image = UIImage(data: data)
        }catch {
            print("I am here")
        }
        //cell.imageView?.image = UIImage(named: "nop")
        //        do{
        //            // try cell.imageView?.image = UIImage(data: Data(contentsOf: URL(fileURLWithPath: ph)))
        //            let url = URL(string: ph)
        //            let data = try Data(contentsOf: url!)
        //            cell.imageView?.image = UIImage(data: data)
        //        }catch {
        //            print("I am here")
        //        }
        return cell
    }
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        searchedFood = food.filter({ (f:Recepies) -> Bool in
            return f.name.lowercased().contains(searchText.lowercased())
            //  return true
        })
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        var ch = self.food[(indexPath as NSIndexPath).item]
        var vc = Recepies2ViewController()
        vc.recept = ch
//        //vc.challange = ch
        self.navigationController?.pushViewController(vc, animated: true)
        return indexPath
    }
    
    
}
extension RecepiesViewController: UISearchResultsUpdating {
    // @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //  isSearched = true
        //hello
        filterContentForSearchText(searchText: search.searchBar.text!)
    }
    
    
    
}

