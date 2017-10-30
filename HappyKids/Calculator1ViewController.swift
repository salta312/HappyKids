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

class Calculator1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var button1 = UIButton(frame: CGRect(x: 50, y:100, width: 100, height: 50))
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.setTitle("Hello", for: .normal)
        view.backgroundColor = UIColor.white

        view.addSubview(button1)
        button1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    
        
    }
    func buttonPressed(){
        print("Hello")
    }
    
}
