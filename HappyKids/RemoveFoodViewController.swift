//
//  RemoveFoodViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 3/2/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import SwiftSpinner
import Cartography

class RemoveFoodViewController: UIViewController {
    var myChild: Child!
    var backednless = Backendless.sharedInstance()
    var cart: [Cart]!
    var food = [Food]()
    var v = UIScrollView()
    var arr2 = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Connecting...")
        self.getCartFromDb()
        view.backgroundColor = UIColor(red: 174/255, green: 138/255, blue: 236/255, alpha: 1)
        v.backgroundColor = UIColor(red: 106/255, green: 142/255, blue: 211/255, alpha: 1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCartFromDb(){
        SwiftSpinner.show("Connecting")
        guard let num = myChild.objectId else{
            return
        }
        let queryOptions = QueryOptions()
        var query = "Child.objectId = '\(num)'"
        var dataQuery = BackendlessDataQuery()
        queryOptions.relationsDepth = 3
        //queryOptions.related = ["Food"];
        dataQuery.whereClause = query
        dataQuery.queryOptions = queryOptions
        var error: Fault?
        let bc = backednless?.data.of(Cart.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
            var bc1 = bc?.data as! [Cart]
            self.cart = bc1
            for n in bc1{
                //retrieve fruit
                self.retrieveFruit(c: n)
         //       self.caclEaten(cart: n)
                
            }
            SwiftSpinner.hide()
         //   self.draw(map: self.eatenVit)
        }else{
            SwiftSpinner.hide()
            print("Server reported an error: \(error)")
            self.showAnAlert(message: "Server reported an error: \(error)")

        }
        self.draw(arr: self.food)
        
    }
    func retrieveFruit(c: Cart){
        guard let id = c.FoodId else{
            return
        }
        let queryOptions = QueryOptions()
        var query = "objectId = '\(id)'"
        var dataQuery = BackendlessDataQuery()
        queryOptions.relationsDepth = 3
        //queryOptions.related = ["Food"];
        dataQuery.whereClause = query
        dataQuery.queryOptions = queryOptions
        var error: Fault?
        let bc = backednless?.data.of(Food.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
            //need to display all the food
            var bc1 = bc?.data as! [Food]
            for n in bc1{
                self.food.append(n)
            }
        }else{
            SwiftSpinner.hide()
            print("Server reported an error: \(error)")
            self.showAnAlert(message: "Server reported an error: \(error)")

        }
    }
    func showAnAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func draw(arr: [Food]){
        view.addSubview(v)
        constrain(view, v){
            view, v in
            v.top == view.top + 100
            v.bottom == view.bottom - 100
            v.left == view.left + 50
            v.right == view.right - 50
        }
        var top = 0
        var height = 70
        var dist = 20
        for ch in arr{
            var butt = UIButton()
            //butt.
            butt.setTitle(ch.name, for: .normal)
            butt.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 79/255, alpha: 1)
            v.addSubview(butt)
            butt.frame = CGRect(x: 70, y: top, width: 150, height: height)
            butt.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            self.arr2.append(butt)
            top += (height + dist)
            
        }
        var but = UIButton()
        but.setTitle("Удалить все", for: .normal)
        but.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 79/255, alpha: 1)
        v.addSubview(but)
        but.frame = CGRect(x: 70, y: top, width: 150, height: height)
        but.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        top += (height + dist)

        if (top + height) >= Int(v.frame.height){
            v.isScrollEnabled = true
            v.setContentOffset(CGPoint(x: 0, y: (Int(v.frame.height) - height)), animated: true)
            //        myView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
            
            v.contentSize = CGSize(width: view.frame.width, height: self.view.frame.height)
            v.showsVerticalScrollIndicator = true
            
        }

    }
    func deleteAll(sender: UIButton){
        guard let id = myChild.objectId else{
            return
        }
        var query = "Child.objectId = '\(id)'"
        var dataQuery = BackendlessDataQuery()
        //queryOptions.related = ["Food"];
        dataQuery.whereClause = query
        var error: Fault?

        let dataStore = backednless?.data.of(Cart.ofClass())
        dataStore?.removeAll(dataQuery, fault: &error)
        if error == nil{
            self.navigationController?.pushViewController(TabBarController(), animated: true)

        }else{
            self.showAnAlert(message: "Server reported an error (2): \(error)")
            print ("Server reported an error (2): \(error)")
        }
    }
    func buttonPressed(sender: UIButton){
        guard let num = self.arr2.index(of: sender) else{
            return
        }
        guard let id = self.cart[num].objectId else{
            return
        }
        let dataStore = backednless?.data.of(Cart.ofClass())
        var error: Fault?
        let result = dataStore?.removeID(id, fault: &error)
        if error == nil{
            print("I am here")
             self.navigationController?.pushViewController(TabBarController(), animated: true)
        }else{
            self.showAnAlert(message: "Server reported an error (2): \(error)")
            print ("Server reported an error (2): \(error)")
        }
        
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
