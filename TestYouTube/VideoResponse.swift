//
//  VideoResponse.swift
//  TestYouTube
//
//  Created by Albert Tagirov on 19.10.16.
//  Copyright © 2016 Albert Tagirov. All rights reserved.
//

import UIKit
import ObjectMapper

class VideoResponse: Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    required init?(map: Map) {
        
    }
    
    
    var videoItems: [Video]?
    
    required init() {
        
    }
    
    func mapping(map: Map){
        videoItems <- map["items"]
    }
    
    
    
}

