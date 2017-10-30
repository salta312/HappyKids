//
//  ChildViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 2/27/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography
import SwiftSpinner

class ChildViewController: UIViewController {
    var v = UIView()
    var gender: String!
    var backendless = Backendless.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = UIColor.white
       // view.backgroundColor = UIColor(colorLiteralRed: 10, green: 243, blue: 58, alpha: 0.7)
        self.construct1View()

        // Do any additional setup after loading the view.
    }
    func construct1View(){
        SwiftSpinner.show("Connecting")
        var label = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        label.text = "Выберите пол малыша"
        
        var button = UIButton()
        button.frame = CGRect(x: 50, y: 250, width: 100, height: 150)
        //button.layer.cornerRadius = 0.5 * button.bounds.size.width
        //button.layer.borderWidth = 5.0
       // button.layer.borderColor = UIColor(red: 1, green: 195, blue: 252, alpha: 1).cgColor
        button.setImage(UIImage(named: "boy"), for: .normal)
        button.addTarget(self, action: #selector(boyButtonPressed), for: .touchUpInside)
        var button2 = UIButton()
        button2.setImage(UIImage(named: "girl"), for: .normal)
        button2.frame = CGRect(x: 200, y: 250, width: 100, height: 150)
        button2.addTarget(self, action: #selector(girlButtonPressed), for: .touchUpInside)

       // button2.layer.cornerRadius = 0.5 * button.bounds.size.width
       // button2.layer.borderWidth = 5.0
     //   button2.layer.borderColor = UIColor(red: 243, green: 104, blue: 231, alpha: 1).cgColor
        v.addSubview(button)
        v.addSubview(button2)
        //v.backgroundColor = UIColor(red: 10/255, green: 243, blue: 58, alpha: 1)
        v.backgroundColor = UIColor(red: 174/255, green: 138/255, blue: 236/255, alpha: 1)
        //v.alpha = 0
        v.addSubview(label)
        var button3 = UIButton(frame: CGRect(x: 50, y:450, width: 250, height: 50))
        button3.setTitle("Отмена", for: .normal)
        button3.setTitleColor(UIColor.gray, for: .normal)
        button3.layer.cornerRadius = 0.5
        button3.layer.borderColor = UIColor.gray.cgColor
        button3.layer.borderWidth = 1.0
        button3.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        v.addSubview(button3)
        view.addSubview(v)
        constrain(v, view){
            v, view in
            v.top == view.top
            v.bottom == view.bottom
            v.left == view.left
            v.right == view.right
        }
        SwiftSpinner.hide()
        
    }
    func boyButtonPressed(){
        gender = "boy"
        self.construct2View()
        
    }
    func girlButtonPressed(){
        gender = "girl"
        self.construct2View()
    }
    func construct2View(){
        self.v.removeFromSuperview()
        var v = UIView(frame: CGRect(x: 0, y:0, width:view.frame.size.width, height: view.frame.size.height))
        if gender == "boy"{
            v.backgroundColor = UIColor(red: 186/255, green: 243.0/255, blue: 248/255, alpha: 0.7)
        }else{
            v.backgroundColor = UIColor(red: 241/255, green: 206/255, blue: 249/255, alpha: 0.7)
        }
        //v.backgroundColor = UIColor.white
        var label = UILabel(frame: CGRect(x: 50, y: 60, width: 200, height: 50))
        label.text = "Выберите возраст"
        v.addSubview(label)
        var but1 = UIButton(frame: CGRect(x: 10, y: 150, width: 100, height: 200))
        but1.setImage(UIImage(named: "baloon1"), for: .normal)
        but1.addTarget(self, action: #selector(finButtonPressed), for: .touchUpInside)
        var but2 = UIButton(frame: CGRect(x: 120, y: 150, width: 100, height: 200))
        but2.setImage(UIImage(named: "baloon2"), for: .normal)
        but2.addTarget(self, action: #selector(finButtonPressed), for: .touchUpInside)
        var but3 = UIButton(frame: CGRect(x: 230, y: 150, width: 100, height: 200))
        but3.setImage(UIImage(named: "baloon3"), for: .normal)
        but3.addTarget(self, action: #selector(finButtonPressed), for: .touchUpInside)
        var button3 = UIButton(frame: CGRect(x: 50, y:450, width: 250, height: 50))
        button3.setTitle("Отмена", for: .normal)
        button3.setTitleColor(UIColor.gray, for: .normal)
        button3.layer.cornerRadius = 0.5
        button3.layer.borderColor = UIColor.gray.cgColor
        button3.layer.borderWidth = 1.0
        button3.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        v.addSubview(button3)
        v.addSubview(but1)
        v.addSubview(but2)
        v.addSubview(but3)
        v.addSubview(button3)
        view.addSubview(v)
        
    }
    var nam: String!
    func cancel(){
      //  SwiftSpinner.show("Connecting...")
        self.navigationController?.pushViewController(TabBarController(), animated: true)
       // SwiftSpinner.hide()
     //   self.dismiss(animated: true, completion: nil)

    }
    func finButtonPressed(){
        self.showAnAlert()

    }
    var d: Diet!
    func retrieveDiet(){
        SwiftSpinner.show("Connecting")
        let dataStore = backendless?.data.of(Diet.ofClass())
        var error: Fault?
        let result = dataStore?.find(&error)
        if error == nil{
            let diets = result?.getCurrentPage()
            for obj in diets!{
                d = obj as! Diet
               // print(d.Minerals)
            }
        }else{
            print("Server reported an error: \(error)")
            return
        }
        SwiftSpinner.hide()
        self.addDiet()
        
    }
    func showAnAlert(){
        var txt = UITextField()
        let alert = UIAlertController(title: "Alert", message: "Имя", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "0"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            let text = alert.textFields![0]
            guard let t = text.text else{
                return
            }
            self.alertInput(name: t)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func alertInput(name: String){
        self.nam = name
        self.retrieveDiet()

    }
    //first version
  /*  func addDiet(){
        var utd = UserToDiet()
        utd.User = backendless?.userService.currentUser
        utd.Dieta = d
        let dataStore = backendless?.data.of(UserToDiet.ofClass())
        var error: Fault?
        let result = dataStore?.save(utd, fault: &error) as? UserToDiet
        if error == nil{
            print("Contact has been saved: \(result!.objectId)")
            self.navigationController?.pushViewController(TabBarController(), animated: true)
        }else{
            print("Server reported an error: \(error)")
        }
    }*/
    func addDiet(){
        SwiftSpinner.show("Connecting...")
        var child = Child()
        guard let parent = backendless?.userService.currentUser else{
            return
        }
        child.parent = parent
        child.diet = d
        child.name = self.nam
        print(d.objectId)
        child.dietId = d.objectId
        let dataStore = backendless?.data.of(Child.ofClass())
        var error: Fault?
        let result = dataStore?.save(child, fault: &error) as? Child
        if error == nil{
            print("Contact has been saved: \(result!.objectId)")
            SwiftSpinner.hide()
            self.navigationController?.pushViewController(TabBarController(), animated: true)
        }else{
            SwiftSpinner.hide()
            print("Server reported an error: \(error)")
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
