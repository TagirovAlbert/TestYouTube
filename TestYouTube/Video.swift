//
//  Video.swift
//  TestYouTube
//
//  Created by Albert Tagirov on 27.07.16.
//  Copyright © 2016 Albert Tagirov. All rights reserved.
//

import UIKit
import ObjectMapper

class Video: Mappable {
    
    var videoId: String = ""
    var title: String = ""
    var description: String = ""
    var thumbnailMax: String = ""
    
    init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map){
        videoId <- map["snippet.resourceId.videoId"]
        title <- map["snippet.title"]
        description <- map["snippet.description"]
        thumbnailMax <- map["snippet.thumbnails.maxres.url"]
    }

}
