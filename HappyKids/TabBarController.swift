//
//  TabBarController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 2/24/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import SwiftSpinner

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var backendless = Backendless.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // self.view.backgroundColor = UIColor.green

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //SwiftSpinner.hide()

       // self.view.backgroundColor = UIColor.green
        self.navigationItem.setHidesBackButton(true, animated: true)
        let quitBut = UIBarButtonItem(title: "Выйти", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutUserSync))
        let profileBut = UIBarButtonItem(image: UIImage(named:"user"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(profileButtonPresed))
        self.navigationItem.leftBarButtonItem = profileBut
        // self.navigationController?.navigationItem.rightBarButtonItem = quitBut
        self.navigationItem.rightBarButtonItem = quitBut
        let tab1 = ViewController()
        let tabOneBarItem = UITabBarItem(title: "food", image: UIImage(named: "apple"), selectedImage: UIImage(named: "apple"))
        tab1.tabBarItem = tabOneBarItem
        let tab2 = RecepiesViewController()
        let tabTwoBarItem = UITabBarItem(title: "recipes", image: UIImage(named: "rec"), selectedImage: UIImage(named: "rec"))
        tab2.tabBarItem = tabTwoBarItem
        let tab3 = Child3ViewController()
        let tabThreeBarItem = UITabBarItem(title: "calculator", image: UIImage(named: "calc"), selectedImage: UIImage(named: "calc"))
        tab3.tabBarItem = tabThreeBarItem
        self.viewControllers = [tab1, tab2, tab3]
        
    }
    func profileButtonPresed(){
       // print("I am here")
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
      //  print("Selected \(viewController.title!)")
    }
    func logoutUserSync() {
        Types.tryblock({
            self.backendless?.userService.logout()
            // self.present(SecondViewController(), animated: true, completion: nil)
            self.navigationController?.pushViewController(SecondViewController(), animated: true)
            
        }) { (expection) -> Void in
            print("Server reported an error: \(expection as! Fault)")
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
