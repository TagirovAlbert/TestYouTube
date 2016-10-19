//
//  VideoModel.swift
//  TestYouTube
//
//  Created by Albert Tagirov on 27.07.16.
//  Copyright © 2016 Albert Tagirov. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    
    let API_KEY = "AIzaSyAmho2teI39KfWjbiRsrOVWKH8HF8cYPeU"
    let PLAYLIST_ID = "PLFEgnf4tmQe-p7tCo41kjd_sAdUezUPM8"
    let youTubePLaylist = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    var arrayVideos = [Video]()
    
    
    var delegate: VideoModelDelegate?
    
    func getFeedVideos() {
            var videoArray = [Video]()
            Alamofire.request(youTubePLaylist, method: .get, parameters: ["part":"snippet", "playlistId": PLAYLIST_ID, "key": API_KEY ]).responseObject { (response: DataResponse<VideoResponse>) in
                let videoResponse = response.result.value
                print(videoResponse)
                print(videoResponse?.videoItems)
                if let videos = videoResponse?.videoItems{
                    for video in videos{
                        videoArray.append(video)
                        
                        
                    }
                    print(videoArray)
                    self.arrayVideos = videoArray
                    self.delegate?.dataReady()
                    
                }
            }
        
        
    }
    
    
    func imageDownload(url: String) -> UIImage {
        var image = UIImage()
        Alamofire.download(url).responseData { (response) in
            if let data = response.result.value{
                image = UIImage(data: data)!
            }
        }.resume()
        
        return image
        
    }
    
    
    
   
}

