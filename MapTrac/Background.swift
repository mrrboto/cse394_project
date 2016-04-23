//
//  Background.swift
//  MapTrac
//
//  Created by user on 4/22/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func addBackground(color: String) {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        if(color == "good")
        {
          imageViewBackground.image = UIImage(named: "green_bg.png")
        }
        else
        {
           imageViewBackground.image = UIImage(named: "red_bg.png")
        }
        
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }}
