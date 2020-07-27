//
//  LetterImageGenerate.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class LetterImageGenerate: NSObject {

    class func imageWith(name: String?) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.ImageLetter.letterImageGeneratorBackground
        nameLabel.textColor = UIColor.ImageLetter.letterImageGeneratorLabel
        nameLabel.layer.borderColor = UIColor.white.cgColor
        nameLabel.font = .systemFont(ofSize: 28)
        var initials = ""
        
        if let initialsArray = name?.components(separatedBy: " ") {
            if let firstWord = initialsArray.first {
                if let firstLetter = firstWord.first {
                    initials += String(firstLetter).capitalized
                }
            }
            if initialsArray.count > 1, let lastWord = initialsArray.last {
                if let lastLetter = lastWord.first {
                    initials += String(lastLetter).capitalized
                }
            }
        } else {
            return UIImage()
        }
        
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage!
        }
        
        return UIImage()
    }
}
