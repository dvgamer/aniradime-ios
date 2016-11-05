//
//  FeedViewController.swift
//  aniradime
//
//  Created by rakuishi on 2016/10/31.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit
import SafariServices

class FeedViewController: UITableViewController, NADViewDelegate {

    var feedModel: FeedModel = FeedModel()
    var nadView: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(FeedViewController.pullRefreshControll), for: UIControlEvents.valueChanged)
        
        let imageView :UIImageView! = UIImageView(image: UIImage(named: "navbar_icon"))
        self.navigationItem.titleView = imageView

        // Remove navigationBar's 1px border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = ""
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.size.width - 320.0) / 2.0
        let height = bounds.size.height - 50.0
        
        self.nadView = NADView.init(frame: CGRect.init(x: width, y: height, width: 320.0, height: 50.0))
        self.nadView.setNendID(Nend.ApiKey.rawValue, spotID: Nend.SpotID.rawValue)
        self.nadView.load()
        self.nadView.delegate = self
        self.navigationController?.view.addSubview(self.nadView)
        
        self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 50.0, 0.0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 50.0, 0.0)

        fetch(isFirstPage: true)
    }
    
    deinit {
        self.nadView.delegate = nil
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

    func nadViewDidFinishLoad(_ adView: NADView!) {
        // print("nadViewDidFinishLoad")
    }
}

