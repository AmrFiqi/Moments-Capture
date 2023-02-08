//
//  PersonCell.swift
//  Moment Capturer
//
//  Created by Amr El-Fiqi on 08/02/2023.
//

import UIKit

class PersonCell: UITableViewCell {


    @IBOutlet var imageViewer: UIImageView!
    @IBOutlet var captioned: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
