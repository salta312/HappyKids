//
//  ProfileViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 3/2/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography
import SwiftSpinner

class ProfileViewController: UIViewController {
    var backednless = Backendless.sharedInstance()
    var arr = [Child]()
    var v = UIScrollView()
    var arr2 = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Connecting...")
        self.getKidsFromDB()
        view.backgroundColor = UIColor(red: 15/255, green: 240/255, blue: 245/255, alpha: 1)
        v.backgroundColor = UIColor(red: 248/255, green: 124/255, blue: 209/255, alpha: 1)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            // tableView.reloadData()
            self.draw(arr: self.arr)
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
    func draw(arr: [Child]){
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
            butt.backgroundColor = UIColor(red: 124/255, green: 248/255, blue: 127/255, alpha: 1)
            v.addSubview(butt)
            butt.frame = CGRect(x: 70, y: top, width: 150, height: height)
            butt.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            self.arr2.append(butt)
            top += (height + dist)
            
        }
        var but = UIButton()
        but.setTitle("+", for: .normal)
        but.backgroundColor = UIColor(red: 124/255, green: 248/255, blue: 127/255, alpha: 1)
        v.addSubview(but)
        but.frame = CGRect(x: 70, y: top, width: 150, height: height)
        but.addTarget(self, action: #selector(addChild), for: .touchUpInside)
        top += (height + dist)
        
        if (top + height) >= Int(v.frame.height){
            v.isScrollEnabled = true
            v.setContentOffset(CGPoint(x: 0, y: (Int(v.frame.height) - height)), animated: true)
            //        myView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
            
            v.contentSize = CGSize(width: view.frame.width, height: self.view.frame.height)
            v.showsVerticalScrollIndicator = true
            
        }
        
    }
    func addChild(sender: UIButton){
        // in case of an emergency change here
        //  self.navigationController?.pushViewController(ChildViewController(), animated: true)
        self.navigationController?.pushViewController(DeseaseViewController(), animated: true)
        
    }
    func buttonPressed(sender: UIButton){
        guard let index = arr2.index(of: sender) else{
            return
        }
        var vc = RemoveFoodViewController()
        var ch = self.arr[index]
        vc.myChild = ch
        //vc.challange = ch
        self.navigationController?.pushViewController(vc, animated: true)
        
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
