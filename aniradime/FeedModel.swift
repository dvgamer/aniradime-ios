//
//  RadioModel.swift
//  aniradime
//
//  Created by rakuishi on 2016/10/31.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FeedModel: NSObject {
    
    private var feeds: [Feed]! = []
    private var formatter: DateFormatter!
    private var num: Int! = 1
    private var isLoading: Bool! = false
    private var hasNextPage: Bool! = false

    override init() {
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "yyyy/MM/dd"
    }

    func fetch(isFirstPage: Bool, errorHandler handler: @escaping (NSError?) -> Void) {
        if self.isAvailableToFetchNextPage() == true {
            let error = NSError(domain: "I'm sorry. But, I have my hands full.", code: -1, userInfo: nil)
            handler(error)
        }
        
        self.isLoading = true
        self.num = isFirstPage ? 1 : self.num + 1
        let url = "http://radio.rakuishi.com/api/v1/feeds?num=" + String(num)

        // TODO: Cancell all requests before `Alamofire.request()`
        Alamofire.request(url)
            .validate()
            .responseJSON { response in
                if response.data != nil && response.result.error == nil {
                    let jsonString = String(data: response.data!, encoding: .utf8)
                    let feeds: [Feed]! = Mapper<Feed>().mapArray(JSONString: jsonString!)
                    if isFirstPage == true {
                        self.feeds = []
                    }
                    self.feeds.append(contentsOf: feeds)

                    self.hasNextPage = Bool(feeds.count != 0)
                    self.isLoading = false
                    handler(nil)
                } else {
                    self.isLoading = false
                    handler(response.result.error as? NSError)
                }
            }
    }

    func isAvailableToFetchNextPage() -> Bool {
        return self.hasNextPage && !self.isLoading
    }

    func sectionCount() -> Int {
        return self.feeds.count;
    }

    func sectionTitle(_ section: Int) -> String {
        let comp = Calendar.Component.weekday
        let weekday = NSCalendar.current.component(comp, from: self.feeds![section].date!)

        return self.formatter.string(from: self.feeds![section].date!) + " " + self.formatter.shortWeekdaySymbols[weekday - 1];
    }
    
    func rowCount(_ section: Int) -> Int {
        return self.feeds![section].radios.count
    }
    
    func radioAtIndexPath(_ indexPath: IndexPath) -> Radio? {
        if indexPath.section < self.feeds!.count {
            return self.feeds![indexPath.section].radios[indexPath.row]
        } else {
            return nil
        }
    }
}
