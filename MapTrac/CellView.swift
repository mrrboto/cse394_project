//
//  CellView.swift
//  MapTrac
//
//  Created by user on 4/18/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import UIKit

class CellView: UITableViewCell {
    
    //@IBOutlet weak var placeName: UILabel!
    //@IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodImage: UIImageView!

    @IBOutlet weak var badName: UILabel!
    @IBOutlet weak var badImage: UIImageView!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
