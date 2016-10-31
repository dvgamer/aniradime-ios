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

class RadioModel: NSObject {
    
    var radios:[Radio]? = []
    
    func fetch(completionHandler handler: @escaping (NSError?) -> Void) {
        let url = "http://radio.rakuishi.com/api/v1/feeds"
        
        Alamofire.request(url)
            .validate()
            .responseJSON { response in
                if response.data != nil && response.result.error == nil {
                    let jsonString = String(data: response.data!, encoding: .utf8)
                    self.radios = Mapper<Radio>().mapArray(JSONString: jsonString!)
                    handler(nil)
                } else {
                    handler(response.result.error as? NSError)
                }
            }
    }
    
    func rowCount() -> Int {
        return self.radios!.count
    }
}
