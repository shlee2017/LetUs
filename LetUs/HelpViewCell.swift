//
//  HelpViewCell.swift
//  LetUs
//
//  Created by Sangheon Lee on 4/7/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class HelpViewCell: UITableViewCell {
    
    //MARKS: Properties
    @IBOutlet weak var request: UILabel!
    
    
    func setHelp(help: String){
        request.text = help
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

