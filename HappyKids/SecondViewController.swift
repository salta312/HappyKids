//
//  SecondViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 2/27/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography
import SwiftSpinner
//import NVActivityIndicatorView



class SecondViewController: UIViewController {
    var backendless = Backendless.sharedInstance()
    var view2 = UIView();
    let email = UITextField()
    let password = UITextField()
    let name = UITextField()
    let button = UIButton()
    var currentView = "login"
    var emailText = ""
    var passwordText = ""
    
    override func viewDidLoad() {
        // super.viewDidLoad()
        // view.backgroundColor = UIColor.blue
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        //let quitBut = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem., target: <#T##Any?#>, action: <#T##Selector?#>)
        let quitBut = UIBarButtonItem(title: "quit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutUserSync))
        //self.navigationController?.navigationItem.rightBarButtonItem = quitBut
        var loginButton = UIButton();
        var registerButton = UIButton();
        var view1 = setLoginView()
        loginButton.backgroundColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
        registerButton.backgroundColor = UIColor(red: 112/255, green: 128/255, blue: 144/255, alpha: 1)
        addViewToSuperView(view3: view1, button1: loginButton, button2: registerButton)
        
        
        
        // Do any additional setup after loading the view.
    }
    func logoutUserSync() {
        SwiftSpinner.show("Connecting...")
        Types.tryblock({
            self.backendless?.userService.logout()
            self.present(ViewController(), animated: true, completion: nil)
        }) { (expection) -> Void in
            print("Server reported an error: \(expection as! Fault)")
        }
        SwiftSpinner.hide()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addViewToSuperView(view3: UIView, button1: UIButton, button2:UIButton){
        //  var view1 = setLoginView()
        view.backgroundColor = UIColor.white
        button1.addTarget(self, action: #selector(showLoginView), for: .touchUpInside)
        // button1.backgroundColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
        button2.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
        //button2.backgroundColor = UIColor(red: 112/255, green: 128/255, blue: 144/255, alpha: 1)
        button1.setTitle("Login", for: .normal)
        button2.setTitle("Register", for: .normal)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(view3)
        constrain(button1, button2,view3, view){
            loginButton, registerButton, view1, view in
            loginButton.top == view.centerY - 100
            loginButton.height == 20
            loginButton.width == (view.width)/4
            loginButton.centerX == view.centerX - 50
            registerButton.top == view.centerY - 100
            registerButton.height == 20
            registerButton.width == (view.width)/4
            registerButton.centerX == view.centerX + 50
            view1.top == loginButton.bottom
            view1.centerX == view.centerX
            view1.width == view.width - 20
            view1.height == 150
            
        }
    }
    func setLoginView() -> UIView{
        // let loginView = UIView();
        view2.backgroundColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1);
        email.borderStyle = UITextBorderStyle.roundedRect
        email.placeholder = "email"
        password.borderStyle = UITextBorderStyle.roundedRect
        password.placeholder = "password"
        password.isSecureTextEntry = true
        button.setTitle("login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        view2.addSubview(email)
        view2.addSubview(password)
        view2.addSubview(button)
        constrain(email, password, button, view2){
            email, password, button, loginView in
            email.top == loginView.top + 10
            email.width == loginView.width - 20
            email.centerX == loginView.centerX
            email.height == 20
            password.top == email.bottom + 10
            password.height == 20
            password.width == loginView.width - 20
            password.height == 20
            password.centerX == loginView.centerX
            button.top == password.bottom + 10
            button.height == 20
            button.width == loginView.width - 20
            button.height == 20
            button.centerX == loginView.centerX
        }
        return view2
        
    }
    
    func setRegisterView() -> UIView{
        var registerView = UIView();
        registerView.backgroundColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1);
        //  let email = UITextField()
        email.borderStyle = UITextBorderStyle.roundedRect
        email.placeholder = "email"
        //  let name = UITextField()
        name.borderStyle = UITextBorderStyle.roundedRect
        name.placeholder = "name"
        // let password = UITextField()
        password.borderStyle = UITextBorderStyle.roundedRect
        password.placeholder = "password"
        password.isSecureTextEntry = true
        let button = UIButton()
        button.setTitle("register", for: .normal)
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        //button.addTarget(self, action: #selector(ViewController.registerUser(email:email.text!, password:password.text!)), for: .touchUpInside)
        //  button.addTarget(self, action: #selector(ViewController.registerUser(email:email.text!, password:password.text!)), for: .touchUpInside)
        //button.addTarget(self, action: #selector(registerUser(email: email.text!, password: password.text!)), for: .touchUpInside)
        registerView.addSubview(email)
        registerView.addSubview(name)
        registerView.addSubview(password)
        registerView.addSubview(button)
        constrain(email, password, button, name, registerView){
            email, password, button, name, loginView in
            email.top == loginView.top + 10
            email.width == loginView.width - 20
            email.centerX == loginView.centerX
            email.height == 20
            name.top == email.bottom + 10
            name.width == loginView.width - 20
            name.centerX == loginView.centerX
            name.height == 20
            password.top == name.bottom + 10
            password.height == 20
            password.width == loginView.width - 20
            password.height == 20
            password.centerX == loginView.centerX
            button.top == password.bottom + 10
            button.height == 20
            button.width == loginView.width - 20
            button.height == 20
            button.centerX == loginView.centerX
        }
        return registerView
    }
    func showLoginView(){
        var loginButton = UIButton();
        var registerButton = UIButton();
        
        registerButton.backgroundColor = UIColor(red: 112/255, green: 128/255, blue: 144/255, alpha: 1)
        loginButton.backgroundColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
        if currentView != "login"{
            currentView = "login"
            view2.subviews.forEach({ (v) in
                v.removeFromSuperview()
            })
            view.subviews.forEach({ (v) in
                v.removeFromSuperview()
            })
            view2 = setLoginView()
            addViewToSuperView(view3: view2, button1: loginButton, button2: registerButton)
            
        }
        
    }
    func showRegister(){
        var loginButton = UIButton();
        var registerButton = UIButton();
        registerButton.backgroundColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
        loginButton.backgroundColor = UIColor(red: 112/255, green: 128/255, blue: 144/255, alpha: 1)
        if currentView != "register"{
            currentView = "register"
            view2.subviews.forEach({ (v) in
                v.removeFromSuperview()
            })
            view.subviews.forEach({ (v) in
                v.removeFromSuperview()
            })
            view2 = setRegisterView()
            addViewToSuperView(view3: view2, button1: loginButton, button2: registerButton)
            
        }
        
        
    }
    func registerUser(){
        guard var emailText = email.text else{
            return
        }
        guard var passwordText = password.text else{
            return
        }
        guard var nameText = name.text else{
            return
        }
        var actIndicator = UIActivityIndicatorView()
        actIndicator.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2, width: 20, height: 20)
        actIndicator.center = view.center
        actIndicator.hidesWhenStopped = true
        actIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        actIndicator.color = UIColor.black
        
        //actIndicator.startAnimating()
        SwiftSpinner.show("Connecting...")
        view.addSubview(actIndicator)
        Types.tryblock({
            let user = BackendlessUser()
            user.email = NSString(string: emailText)
            user.password = NSString(string: passwordText)
            user.name = NSString(string: nameText)
            let registerUser = self.backendless?.userService.registering(user)
            
        }) { (exception) -> Void in
            SwiftSpinner.hide()
            print(exception)
            return
        }
        SwiftSpinner.hide()
       // actIndicator.stopAnimating()
        loginButtonPressed()
        
        
    }
    func loginButtonPressed(){
       // var actIndicator = UIActivityIndicatorView()
//        actIndicator.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2, width: 20, height: 20)
//        actIndicator.center = view.center
//        actIndicator.hidesWhenStopped = true
//        actIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
//        actIndicator.color = UIColor.black
//        actIndicator.startAnimating()
        SwiftSpinner.show("Connecting")
       // view.addSubview(actIndicator)
        guard var emailText = email.text else{
            return
        }
        guard var passwordText = password.text else{
            return
        }
        Types.tryblock({
            let user = self.backendless?.userService.login(emailText, password: passwordText)
            print(" I am \(user)")
        }) { (exc) -> Void in
            print(exc)
            SwiftSpinner.hide()
            self.showAlert(msg: "something went wrong")
            return
        }
        SwiftSpinner.hide()
        //actIndicator.stopAnimating()
        self.backendless?.userService.setStayLoggedIn(true)
        self.navigationController?.pushViewController(DeseaseViewController(), animated: true)
        //
    }
    func showAlert(msg: String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
