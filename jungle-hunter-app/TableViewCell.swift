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
    @IBOutlet weak var trail_length: UILabel!
        
    @IBOutlet weak var controlpoint_name: UILabel!
    @IBOutlet weak var controlpoint_comment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
