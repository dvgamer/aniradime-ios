//
//  SettingsViewController.swift
//  aniradime
//
//  Created by rakuishi on 2016/11/04.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove navigationBar's 1px border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Settings"
    }

    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
