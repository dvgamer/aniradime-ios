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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "About aniradime"
        default:
            return "3rd Party Licenses"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 44.0
        default:
            return 150.0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetailCell", for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Version"
                cell.detailTextLabel?.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String?
            default:
                cell.textLabel?.text = "Developed by"
                cell.detailTextLabel?.text = "rakuishi"
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LisenceCell", for: indexPath) as! LicenseCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 1 {
                let url = URL(string: "http://rakuishi.com")
                let viewController = SFSafariViewController(url: url!)
                present(viewController, animated: true)
            }
        default:
            break
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
