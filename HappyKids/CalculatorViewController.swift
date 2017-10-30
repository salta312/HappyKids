//
//  CalculatorViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 3/1/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography
import SwiftSpinner

class CalculatorViewController: UIViewController {
    var myChild: Child!
    var backednless = Backendless.sharedInstance()
    var eatenVit = [String: Float]()
    var eatenMin = [String: Float]()
    var dietVit = [String: Float]()
    var dietMin = [String: Float]()
    var needVit = [String: Float]()
    var needMin = [String: Float]()
    var v = UIScrollView()
      var prevButton = UIButton()
    var prevButton1 = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.myChild.name)
  

        SwiftSpinner.show("Connecting to satellite...")
       // var imgView = UIImageView(UIImage(named: "fv"))
        self.draw1()
        self.getCartFromDb()
        

        // Do any additional setup after loading the view.
    }
    var button4 = UIButton()
    var button5 = UIButton()
    func draw1(){
        var button1 = UIButton()
        var button2 = UIButton()
        var button3 = UIButton()

        var imgView = UIImageView(image: UIImage(named: "fv"))
        view.backgroundColor = self.randCol()
        imgView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height/4 + 100))
        view.addSubview(imgView)
        let smallView1 = UIView(frame: CGRect(x:0, y: (view.frame.height/4), width:view.frame.width, height:(100)))
        let smallView2 = UIView()
        prevButton = button1
      //  prevButton = button4
        smallView2.backgroundColor = UIColor.darkGray
        smallView2.alpha = 0.7
        smallView1.backgroundColor = UIColor.darkGray
        smallView1.alpha = 0.9
        //  smallView1.addSubview(smallView2)
        //        constrain(smallView1, smallView2){
        //            smallView1, smallView2 in
        //            smallView2.top == smallView1.top + 50
        //            smallView2.bottom == smallView1.bottom
        //            smallView2.left == smallView1.left
        //            smallView2.right == smallView1.right
        //        }
        
        
        button4.setTitle("Витамины", for: .normal)
        button4.setTitleColor(UIColor.white, for: .normal)
        button5.setTitle("Минералы", for: .normal)
        button5.setTitleColor(UIColor.white, for: .normal)
      //  smallView2.addSubview(button4)
       // smallView2.addSubview(button5)
//        constrain(smallView2, button4, button5){
//            smallView2, button4, button5 in
//            button4.left == smallView2.left + 10
//            button4.width == 100
//            button4.height == 50
//            button4.top == smallView2.top
//            button5.width == 100
//            
//            button5.left == smallView2.right - 150
//            button5.height == 50
//            button5.top == smallView2.top
//        }
        //button4.frame = CGRect(x:, y: width: height:)
        //imgView.addSubview(smallView1)
        view.addSubview(smallView1)
        //        vitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)


        button1.setTitle("Съел", for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        button2.setTitle("Диета", for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        button3.setTitle("Недостаток", for: .normal)
        button3.setTitleColor(UIColor.white, for: .normal)
        self.prevButton = button1
        self.prevButton1 = button4
        button4.setTitleColor(UIColor.red, for: .normal)
        button1.setTitleColor(UIColor.red, for: .normal)
       // button1.target(forAction: #selector(buttonPressed1), withSender: self)
        button1.addTarget(self, action: #selector(buttonPressed1), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonPressed1), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonPressed1), for: .touchUpInside)
        smallView1.addSubview(button1)
        smallView1.addSubview(button2)
        smallView1.addSubview(button3)
        constrain(smallView1, button1, button2, button3 ){
            smallView1, button1, button2, button3 in
            button1.top == smallView1.top
            button1.height == 50
            button1.left == smallView1.left + 10
            button1.width == 70
            button2.top == smallView1.top
            button2.height == 50
            button2.left == button1.right + 30
            button2.width == 70
            button3.top == smallView1.top
            button3.height == 50
            button3.left == button2.right + 30
            button3.width == 100
        }
        smallView1.addSubview(button4)
        smallView1.addSubview(button5)
        button4.addTarget(self, action: #selector(buttonPressed2), for: .touchUpInside)
        button5.addTarget(self, action: #selector(buttonPressed2), for: .touchUpInside)
        constrain(smallView1, button4, button5){
            smallView1, button4, button5 in
            button4.bottom == smallView1.bottom
            button4.height == 40
            button4.width == 100
            button4.left == smallView1.left + 20
            button5.bottom == smallView1.bottom
            button5.height == 40
            button5.width == 100
            button5.right == smallView1.right - 120
        }
        
        v.backgroundColor = UIColor.brown
        view.addSubview(v)
        constrain(view, v){
            view, v in
            v.top == view.bottom/4 + 100
            v.bottom == view.bottom
            v.left == view.left
            v.right == view.right
        }
    }
    func buttonPressed2(sender: UIButton){
        if prevButton1 != sender{
            prevButton1.setTitleColor(UIColor.white, for: .normal)
            prevButton1 = sender
            sender.setTitleColor(UIColor.red, for: .normal)
        }
        guard let txt = prevButton.titleLabel?.text else{
            return
        }
        guard let txt1 = sender.titleLabel?.text else{
            return
        }
        if txt1 == "Витамины"{
        if txt == "Съел"{
            self.draw(map: self.eatenVit)
            for ind in self.eatenVit.keys{
                print("\(self.eatenVit[ind]) \(ind)")
            }
        }else if txt == "Диета"{
            self.draw(map: self.dietVit)
            for ind in self.dietVit.keys{
                print("\(self.dietVit[ind]) \(ind)")
            }
        }else{
            self.draw(map: self.needVit)
            for ind in self.needVit.keys{
                print("\(self.needVit[ind]) \(ind)")
            }
        }
        }else{
            if txt == "Съел"{
                self.draw(map: self.eatenMin)
                for ind in self.eatenMin.keys{
                    print("\(self.eatenMin[ind]) \(ind)")
                }
            }else if txt == "Диета"{
                self.draw(map: self.dietMin)
                for ind in self.dietMin.keys{
                    print("\(self.dietMin[ind]) \(ind)")
                }
            }else{
                self.draw(map: self.needMin)
                for ind in self.needMin.keys{
                    print("\(self.needMin[ind]) \(ind)")
                }
            }
        }
    }

    func buttonPressed1(sender: UIButton){
        print("Helloooo")
        button4.setTitleColor(UIColor.red, for: .normal)
        if prevButton != sender{
            prevButton.setTitleColor(UIColor.white, for: .normal)
            sender.setTitleColor(UIColor.red, for: .normal)
            prevButton = sender
            prevButton1.setTitleColor(UIColor.white, for: .normal)
            //button4.setTitleColor(UIColor.red, for: .normal)
           // prevButton1 = button4
         //   print(sender.titleLabel)
            guard let txt = sender.titleLabel?.text else{
                return
            }
            if txt == "Съел"{
                self.draw(map: self.eatenVit)
                for ind in self.eatenVit.keys{
                    print("\(self.eatenVit[ind]) \(ind)")
                }
            }else if txt == "Диета"{
                self.draw(map: self.dietVit)
                for ind in self.dietVit.keys{
                    print("\(self.dietVit[ind]) \(ind)")
                }
            }else{
                self.draw(map: self.needVit)
                for ind in self.needVit.keys{
                    print("\(self.needVit[ind]) \(ind)")
                }
            }
        }
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
    func draw(map: [String: Float]){
        SwiftSpinner.hide()
        var initY = Int(self.v.frame.height/4 - 100)
        var height = 20
        self.v.removeFromSuperview()
        var v = UIScrollView()
        v.backgroundColor = UIColor.darkGray
        v.alpha = 0.7
        //view.backgroundColor = UIColor.white
        for (nameOfVit, num) in map{
            var l = UILabel()
            var l1 = UILabel()
            print("\(nameOfVit) and \(num)")
            l.text = nameOfVit
            l.frame = CGRect(x:10, y: initY, width: 100, height:height)
            l1.text = String(num)
            l1.frame = CGRect(x:200, y: initY, width: 100, height:height)
            v.addSubview(l)
            v.addSubview(l1)
            initY += height + 30
            //print()

        }
        
        if (initY >= Int(view.frame.height)){
            var dif = initY - initY
            v.isScrollEnabled = true
            v.setContentOffset(CGPoint(x: 0, y: dif), animated: true)
            //        myView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)

            v.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
            v.showsVerticalScrollIndicator = true
        }
        self.v = v
        view.addSubview(v)
        constrain(view, v){
            view, v in
            v.top == view.bottom/4 + 100
            v.bottom == view.bottom
            v.left == view.left
            v.right == view.right
        }
        
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
            for n in bc1{
                self.caclEaten(cart: n)
                
            }
            SwiftSpinner.hide()
            self.draw(map: self.eatenVit)
        }else{
            SwiftSpinner.hide()
           print("Server reported an error: \(error)")
        }
       
    }
    /*
    func getCartFromDb(){
        guard let num = myChild.objectId else{
            return
        }
        var whereClause = "Child.objectId = '\(num)'"
        var dataQuery = BackendlessDataQuery()
        let queryOptions = QueryOptions()
        queryOptions.relationsDepth = 10
        dataQuery.queryOptions = queryOptions
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc = backednless?.data.of(Cart.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
           //print("I am here")
            var bc1 = bc?.data as! [Cart]
            for n in bc1{
                self.caclEaten(cart: n)

            }
        }else{
            SwiftSpinner.hide()
            self.showAnAlert(message: "Server reported an error: \(error)")
        }

    }*/
    func splitString(str: String, gram: Int, mapName: String){
        var vitaminsArr = str.components(separatedBy: ", ")
        for n in vitaminsArr{
            var tempArr = n.components(separatedBy: " ")
            if mapName == "vitamins"{
                if let v = eatenVit[tempArr[0]]{
                    eatenVit[tempArr[0]] = Float(tempArr[1])! * Float(Float(gram)/Float(100)) + v
                }else{
                    eatenVit[tempArr[0]] = Float(Float(tempArr[1])! * Float(Float(gram)/Float(100)))
                }
            }else{
                if let v = eatenMin[tempArr[0]]{
                    eatenMin[tempArr[0]] = Float(tempArr[1])! * Float(Float(gram)/Float(100)) + v
                }else{
                    print(Float(Float(tempArr[1])! * Float(Float(gram)/Float(100))))
                    eatenMin[tempArr[0]] = Float(Float(tempArr[1])! * Float(Float(gram)/Float(100)))
                }
            }
        }

        
        
    }
    //diet eaten
    func calcNotEaten(map1: [String: Float], map2: [String: Float], str: String){
        var temp: Float!
            for ind in map1.keys{
                if var k = map2[ind]{
                    if var l = map1[ind]{
                        temp = l - k
                        if temp > 0.00001{
                            if str == "vit"{
                                needVit[ind] = temp
                            }else{
                                needMin[ind] = temp
                            }
                        }
                    }
                }else{
                    if var l = map1[ind]{
                        if str == "vit"{
                            needVit[ind] = map1[ind]
                        }else{
                            needMin[ind] = map1[ind]
                        }
                    }
                }
        }
    }
    
    func caclEaten(cart: Cart){
        //print(myChild.diet.Number)
        SwiftSpinner.show("Connecting")
        guard let gram = Int(cart.gram) else{
            return
        }
        guard let id = cart.FoodId else{
            return
        }
        var whereClause = "objectId = '\(id)'"
        var dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc1 = backednless?.data.of(Food.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
            var bc2 = bc1?.data as! [Food]
            for n in bc2{
              //  print(n.vitamins)
                self.splitString(str: n.vitamins, gram: gram, mapName: "vitamins")
                print(n.minerals)
                self.splitString(str: n.minerals, gram: gram, mapName: "minerals")

            }
            SwiftSpinner.hide()

            self.getDiet()
            
        }else{
            SwiftSpinner.hide()
            self.showAnAlert(message: "Server reported an error: \(error)")
            print("Server reported an error: \(error)")
        }
    }
    func splitStringForDiet(str: String, mapName: String){
        
        var vitaminsArr = str.components(separatedBy: ", ")
        for n in vitaminsArr{
            var tempArr = n.components(separatedBy: " ")
            if mapName == "vitamins"{
                print("\(tempArr[0]) \(Float(tempArr[1])!)")
                self.dietVit[tempArr[0]] = Float(tempArr[1])!
            }else{
                self.dietMin[tempArr[0]] = Float(tempArr[1])!

            }
            
            
        }
    
    }
    func getDiet(){
        SwiftSpinner.show("Connecting")

        guard let id = myChild.dietId else{
            return
        }
        var whereClause = "objectId = '\(id)'"
        var dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc1 = backednless?.data.of(Diet.ofClass()).find(dataQuery, fault: &error)
        if error == nil{
            var bc2 = bc1?.data as! [Diet]
            for n in bc2{
                  print(n.Vitamins)
                self.splitStringForDiet(str: n.Vitamins, mapName: "vitamins")
                self.splitStringForDiet(str: n.Minerals, mapName: "minerals")
            }
            self.calcNotEaten(map1: self.dietVit, map2: self.eatenVit, str: "vit")
            self.calcNotEaten(map1: self.dietMin, map2: self.eatenMin, str: "min")
        }else{
            
        }
        SwiftSpinner.hide()


        
    }
    
    func showAnAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func receiveFood(){
        
        
    }
    /*
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
 */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
