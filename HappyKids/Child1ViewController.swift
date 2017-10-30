//
//  Child1ViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 2/28/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography
import SwiftSpinner

class Child1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView = UITableView()
    var backednless = Backendless.sharedInstance()
    var arr = [Child]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Double(Double(90)/Double(100)))
        SwiftSpinner.show("Connecting to satellite...")
        self.getKidsFromDB()
        view.backgroundColor = UIColor(red: 184/255, green: 240/255, blue: 250/255, alpha: 1)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(red: 243/255, green: 184/255, blue: 250/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        constrain(view, tableView){
            view, tableView in
            tableView.centerX == view.centerX
            tableView.centerY == view.centerY
            tableView.width == 200
            tableView.height == 300
        }
        // Do any additional setup after loading the view.
    }
    func getKidsFromDB(){
        guard let num = backednless?.userService.currentUser.objectId else{
            return
        }
        let whereClause = "parent.objectId = '\(num)'"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc = backednless?.data.of(Child.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
            var bc1 = bc?.data as! [Child]
            self.arr = bc1
            tableView.reloadData()
            SwiftSpinner.hide()
        }else{
            SwiftSpinner.hide()
            self.showAnAlert(message: "Server reported an error: \(error)")
        }
    }
    func showAnAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /*
    
    func addToDB(val: String, ch: Child){
        // print ()
        guard let str = ch.objectId else{
            return
        }
        guard let f = myFood.objectId else{
            return
        }
        print(f)
        let whereClause = "Child.objectId = '\(str)' AND food.objectId = '\(f)'"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc = backendless?.data.of(Cart.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
            print(bc?.data)
            var bc1 = bc?.data as! [Cart]
            print(bc1)
            if bc1.count == 0{
                self.addToDb1(val: val, ch: ch)
            }else{
                self.UpdateCart(cart: bc1[0], val: val)
                // print(bc1[0].food)
                // print("I am here")
            }
        }else{
            print("Server reported an error: \(error)")
        }
    }
 */

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.arr.count
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.arr[(indexPath as NSIndexPath).item].name
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        var ch = self.arr[(indexPath as NSIndexPath).item]
        var vc = CalculatorViewController()
        vc.myChild = ch
        //vc.challange = ch
        self.navigationController?.pushViewController(vc, animated: true)
        return indexPath
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
