//
//  MyScheduleCell.swift
//  iOS-Project
//
//  Created by SABai on 2/06/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class MyScheduleCell: UITableViewCell {

    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var more: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var detail: UILabel!

    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
