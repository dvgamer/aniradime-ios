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

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ViewController.pullRefreshControll), for: UIControlEvents.valueChanged)
        
        let imageView :UIImageView! = UIImageView(image: UIImage(named: "navbar_icon"))
        self.navigationItem.titleView = imageView

        // Remove navigationBar's 1px border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = ""

        fetch(isFirstPage: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullRefreshControll() {
        fetch(isFirstPage: true)
    }

    func fetch(isFirstPage: Bool) {
        self.feedModel.fetch(isFirstPage: isFirstPage, errorHandler: { error -> Void in
            if error == nil {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height && self.feedModel.isAvailableToFetchNextPage() {
            fetch(isFirstPage: false)
        }
    }
}

