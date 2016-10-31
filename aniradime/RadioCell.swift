//
//  RadioCell.swift
//  aniradime
//
//  Created by rakuishi on 2016/10/31.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit

class RadioCell: UITableViewCell {
    
    var radio: Radio!

    override func awakeFromNib() {

    }

    func setRadio(radio: Radio) {
        self.radio = radio
        self.textLabel?.text = self.radio.name
        self.detailTextLabel?.text = self.radio.description
    }
}
