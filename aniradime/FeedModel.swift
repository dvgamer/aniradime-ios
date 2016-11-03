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
    
    var feeds:[Feed]! = []
    var formatter: DateFormatter!

    override init() {
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "yyyy/MM/dd"
    }
    
    func fetch(completionHandler handler: @escaping (NSError?) -> Void) {
        let url = "http://radio.rakuishi.com/api/v1/feeds?num=1"
        
        Alamofire.request(url)
            .validate()
            .responseJSON { response in
                if response.data != nil && response.result.error == nil {
                    let jsonString = String(data: response.data!, encoding: .utf8)
                    self.feeds = Mapper<Feed>().mapArray(JSONString: jsonString!)
                    handler(nil)
                } else {
                    handler(response.result.error as? NSError)
                }
            }
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
