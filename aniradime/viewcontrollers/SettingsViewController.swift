//
//  SettingsViewController.swift
//  aniradime
//
//  Created by rakuishi on 2016/11/04.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit
import SafariServices

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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetailCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Version"
            cell.detailTextLabel?.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String?
        case 1:
            cell.textLabel?.text = "Developed by"
            cell.detailTextLabel?.text = "rakuishi"
        default:
            cell.textLabel?.text = "3rd Party Licenses"
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let url = URL(string: "http://rakuishi.com")
            let viewController = SFSafariViewController(url: url!)
            present(viewController, animated: true)
        case 2:
            let url = URL(string: "https://github.com/rakuishi/aniradime-ios/blob/master/ATTRIBUTIONS.md")
            let viewController = SFSafariViewController(url: url!)
            present(viewController, animated: true)
        default:
            break
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
