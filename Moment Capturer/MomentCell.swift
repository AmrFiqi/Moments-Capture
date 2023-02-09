//
//  PersonCell.swift
//  Moment Capturer
//
//  Created by Amr El-Fiqi on 08/02/2023.
//

import UIKit

class MomentCell: UITableViewCell {


    @IBOutlet var imageViewer: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(withModel model: Moment, imagePath: String) {
        imageViewer.image = UIImage(contentsOfFile: imagePath)
        captionLabel.text = model.name
    }
}
