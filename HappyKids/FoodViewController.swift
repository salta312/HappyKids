//
//  FoodViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 2/26/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography
import SwiftSpinner

protocol FoodAddToDb{
     func addToDB(val: String, ch: Child)
}

class FoodViewController: UIViewController, FoodAddToDb {
    var myFood: Food!
    var myView = UIScrollView()
    var addButton = UIButton()
    var backendless = Backendless.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = self.randCol()
        self.draw()
        self.splitString()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //   func setMyView() -> UIView{
    //        myView.backgroundColor = UIColor.darkGray
    //        myView.alpha = 0.5
    //        var txt = UILabel()
    //        txt.text = "Hello"
    //        view.addSubview(txt)
    //        constrain(myView, txt){
    //            view, txt in
    //            txt.top == myView.top
    //            txt.height == 20
    //            txt.width == 50
    //            txt.left == myView.left
    //        }
    
    //    }
    func draw(){
        myView.backgroundColor = UIColor.darkGray
        myView.alpha = 0.8
        addButton.setTitle("Съесть", for: .normal)
        addButton.backgroundColor = UIColor.darkGray
        addButton.addTarget(self, action: #selector(showAnAlert), for: .touchUpInside)
        var img: UIImage!
        do{
            // try cell.imageView?.image = UIImage(data: Data(contentsOf: URL(fileURLWithPath: ph)))
            let url = URL(string: myFood.pic)
            let data = try Data(contentsOf: url!)
            img = UIImage(data: data)
        }catch {
            print("I am here")
        }
        var imgView = UIImageView(image: img)
        var greyView = UIView()
        greyView.backgroundColor = UIColor.darkGray
        greyView.alpha = 0.5
        view.addSubview(imgView)
        view.addSubview(greyView)
        view.addSubview(myView)
        view.addSubview(addButton)
        constrain(view, imgView, greyView, addButton, myView){
            view, imgView, greyView, addButton, myView in
            imgView.top == view.top + 64
            imgView.bottom == view.centerY
            imgView.right == view.right
            imgView.left == view.left
            greyView.top == view.centerY - 50
            greyView.bottom == view.centerY
            greyView.left == view.left
            greyView.right == view.right
            addButton.bottom == view.bottom
            addButton.left == view.left
            addButton.right == view.right
            addButton.height == 30
            myView.top == imgView.bottom
            myView.bottom == addButton.top
            myView.left == view.left
            myView.right == view.right
        }
        self.fillGreyView(v: greyView)
        var v = self.changeView(txt: "Витамины")
        view.addSubview(v)
        constrain(view, v){
            view, v in
            v.top == view.centerY
            v.bottom == view.bottom
            v.left == view.left
            v.right == view.right
        }
        
        
    }
    var vitButton = UIButton()
    var minButton = UIButton()
    var enButton = UIButton()
    var prevButton: UIButton!
    
    func fillGreyView(v: UIView){
        prevButton = vitButton
        var width = self.view.frame.size.width/3
        vitButton.setTitle("Витамины", for: .normal)
        minButton.setTitle("Минералы", for: .normal)
        enButton.setTitle("Эн. ценность", for: .normal)
        vitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        vitButton.setTitleColor(UIColor.red, for: .normal)
        minButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        minButton.setTitleColor(UIColor.white, for: .normal)
        enButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        enButton.setTitleColor(UIColor.white, for: .normal)
        v.addSubview(vitButton)
        v.addSubview(minButton)
        v.addSubview(enButton)
        constrain(vitButton, minButton, enButton, v){
            vitButton, minButton, enButton, v in
            vitButton.left == v.left
            vitButton.width == width
            vitButton.left == v.left
            //   vitButton.right == v.width/3
            vitButton.height == v.height
            vitButton.top == v.top
            minButton.left == vitButton.right
            minButton.width == width
            minButton.height == vitButton.height
            minButton.top == vitButton.top
            enButton.top == minButton.top
            enButton.height == vitButton.height
            enButton.right == v.right
            enButton.left == minButton.right
        }
    }
    func buttonPressed(sender: UIButton){
        prevButton.setTitleColor(UIColor.white, for: .normal)
        prevButton = sender
        sender.setTitleColor(UIColor.red, for: .normal)
        var v = self.changeView(txt: (sender.titleLabel?.text)!)
        view.addSubview(v)
//        constrain(view, v){
//            view, v in
//            v.top == view.centerY
//            v.bottom == view.bottom
//            v.left == view.left
//            v.right == view.right
//        }
        //sender.setTitle(sender.titleLabel?.text, for: .normal)
    }
    func randNum()-> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
        
    }
    func randCol()-> UIColor{
        return UIColor(red:   self.randNum(),
                       green: self.randNum(),
                       blue:  self.randNum(),
                       alpha: 1.0)
    }
    var vitamins = [String: Float]()
    var minerals = [String: Float]()
    func splitString(){
        var vitaminsArr = myFood.vitamins.components(separatedBy: ", ")
        // var mineralsArr = myFood.minerals.components(separatedBy: <#T##CharacterSet#>)
        
        var mineralsArr = myFood.minerals.components(separatedBy: ", ")
        for n in vitaminsArr{
            var tempArr = n.components(separatedBy: " ")
            //vitamins[vitamins.count] = [tempArr[0]: tempArr[1]]
            vitamins[tempArr[0]] = Float(tempArr[1])
        }
        for n in mineralsArr{
            var tempArr = n.components(separatedBy: " ")
            //vitamins[vitamins.count] = [tempArr[0]: tempArr[1]]
            minerals[tempArr[0]] = Float(tempArr[1])
        }
        // vitamins.forEach { print("\($0): \($1)") }
        // minerals.forEach { print("\($0): \($1)") }
        
        
    }
    func changeView(txt: String) -> UIScrollView{
        var temp = [String: Float]()
        if txt == "Витамины"{
            temp = vitamins
        }else if txt == "Минералы"{
            temp = minerals
        }
        self.myView.removeFromSuperview()
        var myView = UIScrollView(frame: CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2 - 30))
        myView.isScrollEnabled = true
     ///   myView.scrollRectToVisible(CGRect(x:0, y: view.frame.size.height/2, width:view.frame.size.width, height: view.frame.size.height), animated: true)
       // myView.alwaysBounceVertical = true
        myView.setContentOffset(CGPoint(x: 0, y: view.frame.size.height), animated: true)
        myView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        myView.showsVerticalScrollIndicator = true
        // var viewArr = [View]()
        var count = 0;
        var dist = 0;
        for n in temp{
            var v: UIView!
            var l1: UILabel!
            var l2: UILabel!
            if (count % 2 == 0){
                v = UIView(frame: CGRect(x: 50, y: count*50 + count*10, width: 100, height: 60))
                l1 = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 30))
                l1.text = n.key
                l2 = UILabel(frame:  CGRect(x: 10, y: 30, width: 100, height: 30))
                l2.text = String(n.value)
            }else{
                v = UIView(frame: CGRect(x: Int(view.frame.size.width - 150), y: count*50 + count*10, width: 100, height: 60))
                l1 = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 30))
                l1.text = n.key
                l2 = UILabel(frame:  CGRect(x: 10, y: 30, width: 100, height: 30))
                l2.text = String(n.value)
            }
            v.layer.cornerRadius = 10
            //v.layer.cornerRadius = v.frame.size.width/2
            v.backgroundColor = self.randCol()
            v.addSubview(l1)
            v.addSubview(l2)
            myView.addSubview(v)
            count += 1;
            
        }
        self.myView = myView
        return self.myView
    }
    func showAnAlert(){
        var txt = UITextField()
        let alert = UIAlertController(title: "Alert", message: "колличество грамм", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "0"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            let text = alert.textFields![0]
            guard let t = text.text else{
                return
            }

        //    print (txt)
            self.alertInput(val: t)
        }))
        self.present(alert, animated: true, completion: nil)

    }
    func alertInput(val: String) {
        //this needs to be change because I know there is just one child
        self.getUserToDiet(val: val)
        
    }
    func getUserToDiet(val: String){
        SwiftSpinner.show("Connecting...")
        print (val)
        guard let str = backendless?.userService.currentUser.objectId else{
                return
        }
        let whereClause = "parent.objectId = '\(str)'"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc = backendless?.data.of(Child.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
            //print(bc?.data)
            var bc1 = bc?.data as! [Child]
            //changed to 0
            var vc = Child2ViewController()
            vc.arr = bc1
            vc.val = val
            vc.del = self
            SwiftSpinner.hide()
            self.navigationController?.pushViewController(vc, animated: true)

            
            //self.addToDB(val: val, ch: bc1[0])
        }else{
            SwiftSpinner.hide()
            print("Server reported an error: \(error)")
            self.showAnAlert()
        }
        
    }
    func addToDB(val: String, ch: Child){
       // print ()
        SwiftSpinner.show("Connecting")
        guard let str = ch.objectId else{
            return
        }
        guard let f = myFood.objectId else{
            return
        }
        print(f)
        let whereClause = "Child.objectId = '\(str)' AND Food.objectId = '\(f)'"
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
            SwiftSpinner.hide()
            self.navigationController?.pushViewController(TabBarController(), animated: true)

        }else{
            SwiftSpinner.hide()
            print("Server reported an error: \(error)")
            self.showAnAlert()
        }
    }
    func UpdateCart(cart: Cart, val: String){
        SwiftSpinner.show("Connecting...")
        let dataStore = backendless?.data.of(Cart.ofClass())
        guard let val1 = Int(val) else{
            return
        }
        cart.gram = String(Int(cart.gram)! + val1)
        cart.FoodId = myFood.objectId
        var error: Fault?
        dataStore?.save(cart, fault: &error) as? Cart
        if error == nil{
            print("everything is OK")
        }else{
            print("Server reported an error (2): \(error)")
        }
        SwiftSpinner.hide()
    }
    
//    func checkwetherExists(cart: [Cart]){
//        for n in cart{
//            var arr = n.food
//            guard let arr1 = arr else{
//                return
//            }
//            if (arr1.contains(myFood)){
//                guard let ind = arr1.index(of: myFood) else{
//                    return
//                }
//                
//                
//            }
//        }
//    }
    func addToDb1(val: String, ch: Child){
        SwiftSpinner.show("Connecting...")
        print(val)
        let dataStore = backendless?.data.of(Cart.ofClass())
        var error: Fault?
        var c = Cart()
        c.Child = ch
        
        c.gram = val 
        c.FoodId = myFood.objectId
        print (c.gram!)
        c.Food = myFood
        let result = dataStore?.save(c, fault: &error) as? Cart
        if error == nil{
            print("Contact has been saved: \(result!.objectId)")
        }else{
            print("Server reported an error: \(error)")
        }
        SwiftSpinner.hide()
        
    }
    
//    func getUserToDiet(){
//        guard let str = backendless?.userService.currentUser.objectId else{
//            return
//        }
//        let whereClause = "User.objectId = '\(str)'"
//        let dataQuery = BackendlessDataQuery()
//        let queryOption = QueryOptions()
//        queryOption.relationsDepth = 3
//        dataQuery.queryOptions = queryOption
//        dataQuery.whereClause = whereClause
//        var error: Fault?
//        let bc = backendless?.data.of(UserToDiet.ofClass()).find(dataQuery, fault: &error)
//
//       // let bc2 = bc1 as! BackendlessCollection
//
//        if error == nil{
//            print(bc)
//            print(bc?.data)
//            var arr = bc?.data as! [UserToDiet]
//            for n in arr{
//                guard let n1 = n.Dieta else{
//                    return
//                }
//               // var n2 = n1 as! Diet
//                print(n1)
//            }
//  //          print(bc)
//            //print("Contacts have been found: \(bc.data")
//            //print("Contacts have been found: ")
//
//        }else{
//            print("Server reported an error: \(error)")
//        }
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
