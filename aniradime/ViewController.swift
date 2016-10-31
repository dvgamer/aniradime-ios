//
//  ViewController.swift
//  aniradime
//
//  Created by rakuishi on 2016/10/31.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UITableViewController {

    var radioModel:RadioModel = RadioModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "aniradime"
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ViewController.fetch), for: UIControlEvents.valueChanged)

        fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetch() {
        radioModel.fetch(completionHandler: { error -> Void in
            // Reload UITableView ...
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.radioModel.sectionCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.radioModel.rowCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioCell", for: indexPath) as! RadioCell
        if let radio = self.radioModel.radioAtIndexPath(indexPath: indexPath) {
            cell.setRadio(radio: radio)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let radio = self.radioModel.radioAtIndexPath(indexPath: indexPath) {
            print(radio.url)
            let url = URL(string: radio.url)
            let viewController = SFSafariViewController(url: url!)
            present(viewController, animated: true)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

