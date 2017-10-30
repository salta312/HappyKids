//
//  Recepies2ViewController.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 3/2/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography

class Recepies2ViewController: UIViewController {
    var recept: Recepies!
    var img: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPic()
        // Do any additional setup after loading the view.
    }
    func getPic(){
        do{
            // try cell.imageView?.image = UIImage(data: Data(contentsOf: URL(fileURLWithPath: ph)))
            let url = URL(string: recept.pic)
            let data = try Data(contentsOf: url!)
           // cell.imageView?.image = UIImage(data: data)
            img = UIImage(data: data)
            self.draw()
        }catch {
            print("I am here")
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
    func draw(){
        view.backgroundColor = self.randCol()
        var v = UIView()
        v.backgroundColor = UIColor.white
        var imgView = UIImageView(image: img)
        view.addSubview(imgView)
        view.addSubview(v)
        constrain(view, v, imgView){
            view, v, imgView in
            imgView.top == view.top
            imgView.height == 300
            imgView.left == view.left
            imgView.right == view.right
            v.top == imgView.bottom
            v.bottom == view.bottom
            v.left == view.left
            v.right == view.right
        }
        var label1 = UILabel()
        label1.text = recept.name
        var label2 = UILabel()
        label2.text = recept.age
        var label3 = UILabel()
        label3.text = recept.benefits
        var label4 = UILabel()
        label4.text = recept.time
        var label5 = UILabel()
        label5.text = "available soon..."
        v.addSubview(label1)
        v.addSubview(label2)
        v.addSubview(label3)
        v.addSubview(label4)
        v.addSubview(label5)
        label3.numberOfLines = 2
        constrain(v, label1, label2, label3, label4){
            v, label1, label2, label3, label4 in
            label1.top == v.top
            label1.height == 30
            label1.width == 300
            label1.centerX == v.centerX
            label2.top == label1.bottom + 20
            label2.left == v.left + 10
            label2.height == 20
            label2.width == 80
            label3.height == 60
            label3.top == label2.bottom + 10
            label3.width == 300
            label3.left == v.left + 10
            label4.right == v.right - 70
            label4.width == 80
            label4.top == label1.bottom + 20
            label4.height == 20
            
        }
        constrain(v, label3, label5){
            v, label3, label5 in
            label5.height == 30
            label5.width == 300
            label5.centerX == v.centerX
            label5.top == label3.bottom + 20
        }
       // var label = UILabel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
