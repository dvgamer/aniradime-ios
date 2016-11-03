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

    var feedModel:FeedModel = FeedModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ViewController.fetch), for: UIControlEvents.valueChanged)
        
        let imageView :UIImageView! = UIImageView(image: UIImage(named: "navbar_icon"))
        self.navigationItem.titleView = imageView
        // Remove navigationBar's 1px border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = ""

        fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetch() {
        feedModel.fetch(completionHandler: { error -> Void in
            // Reload UITableView ...
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.feedModel.sectionCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedModel.rowCount(section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.feedModel.sectionTitle(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioCell", for: indexPath) as! RadioCell
        if let radio = self.feedModel.radioAtIndexPath(indexPath) {
            cell.setRadio(radio)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let radio = self.feedModel.radioAtIndexPath(indexPath) {
            let url = URL(string: radio.url)
            let viewController = SFSafariViewController(url: url!)
            present(viewController, animated: true)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

