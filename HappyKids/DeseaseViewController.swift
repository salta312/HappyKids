//
//  DeseaseViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 3/2/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography

class DeseaseViewController: UIViewController {
    
    var v = UIScrollView()
    var deseases = ["Здоровый", "отравление", "заболевание кишечника", "сахарный диабет", "ожирение", "болезни почек"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = UIColor(red: 174/255, green: 138/255, blue: 236/255, alpha: 1)
        v.backgroundColor = UIColor(red: 106/255, green: 142/255, blue: 211/255, alpha: 1)
        self.draw(arr: self.deseases)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func draw(arr: [String]){
        view.addSubview(v)
        constrain(view, v){
            view, v in
            v.top == view.top + 100
            v.bottom == view.bottom - 100
            v.left == view.left + 20
            v.right == view.right - 20
        }
        var top = 0
        var height = 70
        var dist = 20
        for ch in arr{
            var butt = UIButton()
            //butt.
            butt.setTitle(ch, for: .normal)
            butt.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 79/255, alpha: 1)
            v.addSubview(butt)
            butt.frame = CGRect(x: 70, y: top, width: 250, height: height)
            butt.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            top += (height + dist)
            
        }
        
        if (top + height) >= Int(v.frame.height){
            v.isScrollEnabled = true
            v.setContentOffset(CGPoint(x: 0, y: (Int(v.frame.height) - height)), animated: true)
            //        myView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
            
            v.contentSize = CGSize(width: view.frame.width, height: self.view.frame.height)
            v.showsVerticalScrollIndicator = true
            
        }
        
    }
    func buttonPressed(sender: UIButton){
        self.navigationController?.pushViewController(ChildViewController(), animated: true)
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
