//
//  ChecklistItemTableViewCell.swift
//  CheckList
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class ChecklistItemTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var checkmarkLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
