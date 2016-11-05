//
//  LicenseCell.swift
//  aniradime
//
//  Created by rakuishi on 2016/11/05.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit

class LicenseCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        // Scroll position is not correct,
        // when following params is set up in a storyboard.
        self.textView.isEditable = false
        self.textView.isSelectable = false
    }
}
