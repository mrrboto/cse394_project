//
//  CellView.swift
//  MapTrac
//
//  Created by user on 4/18/16.
//  Copyright © 2016 VAD. All rights reserved.
//

import UIKit

class CellView: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
