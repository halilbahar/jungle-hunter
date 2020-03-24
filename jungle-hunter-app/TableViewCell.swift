//
//  TableViewCell.swift
//  jungle-hunter-app
//
//  Created by Administrator on 24.03.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var trail_name: UILabel!
    @IBOutlet weak var trail_country: UILabel!
    @IBOutlet weak var trail_start: UILabel!
    @IBOutlet weak var trail_end: UILabel!
    
    
    @IBOutlet weak var controlpoint_name: UILabel!
    @IBOutlet weak var controlpoint_description: UILabel!
    @IBOutlet weak var controlpoint_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
