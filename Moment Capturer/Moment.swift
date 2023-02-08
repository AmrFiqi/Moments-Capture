//
//  Moment.swift
//  Moment Capturer
//
//  Created by Amr El-Fiqi on 08/02/2023.
//

import UIKit

class Moment: NSObject, Codable {
    var name: String
    var image: String

    init(name: String, image: String){
        self.name = name
        self.image = image
    }
}
