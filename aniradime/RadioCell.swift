//
//  RadioCell.swift
//  aniradime
//
//  Created by rakuishi on 2016/10/31.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit
import PINRemoteImage

class RadioCell: UITableViewCell {
    
    @IBOutlet weak var radioTitleLabel: UILabel!
    @IBOutlet weak var radioDescriptionLabel: UILabel!
    @IBOutlet weak var radioThumbnailImageView: UIImageView!
    
    var radio: Radio!

    override func awakeFromNib() {

    }

    func setRadio(_ radio: Radio) {
        self.radio = radio

        self.radioTitleLabel?.text = self.radio.name
        var rect: CGRect! = self.radioTitleLabel.frame
        self.radioTitleLabel.sizeToFit()
        rect.size.height = self.radioTitleLabel.frame.height
        self.radioTitleLabel.frame = rect
        
        let station: String? = self.radio.radioStation?.name
        self.radioDescriptionLabel?.text = "配信元: " + station!
        // Remove an already appeared image, which is recycled by UITableView
        self.radioThumbnailImageView.image = nil
        self.radioThumbnailImageView.pin_setImage(from: URL(string: radio.imageUrl), placeholderImage: nil)
    }
}
