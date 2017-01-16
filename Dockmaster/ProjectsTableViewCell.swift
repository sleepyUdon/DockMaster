//
//  ProjectsTableViewCell.swift
//  Dockmaster
//
//  Created by Viviane Chan on 2017-01-13.
//  Copyright © 2017 VivianeChan. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
