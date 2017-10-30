//
//  MyTableViewCell.swift
//  HappyKids
//
//  Created by Saltanat Aimakhanova on 3/3/17.
//  Copyright © 2017 saltaim. All rights reserved.
//

import UIKit
import Cartography

class MyTableViewCell: UITableViewCell {
    var img: UIImage?
    var name: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        var imgView = UIImageView(image: img)
        contentView.addSubview(imgView)
        var v = UIView()
        v.backgroundColor = UIColor.darkGray
        v.alpha = 0.7
        // v.addSubview(name)
        var label = UILabel()
        label.text = name
        label.textColor = UIColor.white
        label.font = UIFont(name: label.font.fontName, size: 20)
        v.addSubview(label)
        constrain(v, label){
            v, label in
            label.centerX == v.centerX
            label.top == v.top - 10
            label.bottom == v.bottom - 10
            label.width == v.width - 50
        }
        contentView.addSubview(v)
        constrain(imgView, contentView, v){
            imgView, contentView, v in
            imgView.top == contentView.top
            imgView.bottom == contentView.bottom
            imgView.right == contentView.right
            imgView.left == contentView.left
            v.bottom == contentView.bottom
            v.height == 50
            v.width == contentView.width
            v.left == contentView.left
        }

        
        // Initialization code
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var imgView = UIImageView(image: img)
        contentView.addSubview(imgView)
        var v = UIView()
        v.backgroundColor = UIColor.darkGray
        v.alpha = 0.7
       // v.addSubview(name)
        var label = UILabel()
        label.text = name
        label.textColor = UIColor.white
        label.font = UIFont(name: label.font.fontName, size: 30)
        v.addSubview(label)
        constrain(v, label){
            v, label in
            label.centerX == v.centerX
            label.top == v.top - 10
            label.bottom == v.bottom - 10
            label.width == v.width - 50
        }
        contentView.addSubview(v)
        constrain(imgView, contentView, v){
            imgView, contentView, v in
            imgView.top == contentView.top
            imgView.bottom == contentView.bottom
            imgView.right == contentView.right
            imgView.left == contentView.left
            v.bottom == contentView.bottom
            v.height == 50
            v.width == contentView.width
            v.left == contentView.left
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        var imgView = UIImageView(image: img)
        contentView.addSubview(imgView)
        var v = UIView()
        v.backgroundColor = UIColor.darkGray
        v.alpha = 0.7
        // v.addSubview(name)
        var label = UILabel()
        label.text = name
        label.textColor = UIColor.white
        label.font = UIFont(name: label.font.fontName, size: 20)
        v.addSubview(label)
        constrain(v, label){
            v, label in
            label.centerX == v.centerX
            label.top == v.top - 10
            label.bottom == v.bottom - 10
            label.width == 200
        }
        contentView.addSubview(v)
        constrain(imgView, contentView, v){
            imgView, contentView, v in
            imgView.top == contentView.top
            imgView.bottom == contentView.bottom
            imgView.right == contentView.right
            imgView.left == contentView.left
            v.bottom == contentView.bottom
            v.height == 50
            v.width == contentView.width
            v.left == contentView.left
        }

        // Configure the view for the selected state
    }

}
