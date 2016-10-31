//
//  Radio.swift
//  aniradime
//
//  Created by rakuishi on 2016/10/31.
//  Copyright © 2016 rakuishi. All rights reserved.
//

import Foundation
import ObjectMapper

class Radio: Mappable {

    var id: Int = -1
    var name: String = ""
    var url: String = ""
    var imageUrl: String = ""
    var description: String = ""
    var publishedAt: NSDate? = nil
    var radioStationId: Int = -1
    var radioStation: RadioStation? = nil
    
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        url             <- map["url"]
        imageUrl        <- map["image_url"]
        description     <- map["description"]
        publishedAt     <- map["published_at"]
        radioStationId  <- map["radio_station_id"]
        radioStation    <- map["station"]
    }
}

class RadioStation: Mappable {
    
    var id: Int = -1
    var name: String = ""
    var url: String = ""
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        url     <- map["url"]
    }
}
