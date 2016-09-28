//
//  VideoModel.swift
//  TestYouTube
//
//  Created by Albert Tagirov on 27.07.16.
//  Copyright © 2016 Albert Tagirov. All rights reserved.
//
import UIKit

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    
    let API_KEY = "AIzaSyAmho2teI39KfWjbiRsrOVWKH8HF8cYPeU"
    let PLAYLIST_ID = "PLFEgnf4tmQe-p7tCo41kjd_sAdUezUPM8"
    var arrayVideos = [Video]()
    
    
    var delegate: VideoModelDelegate?
    
    func getFeedVideos() {
      Alamofire.request(.GET, "https://www.googleapis.com/youtube/v3/playlistItems", parameters: ["part":"snippet", "playlistId":PLAYLIST_ID, "key":API_KEY], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
        
        
        if let JSON = response.result.value {
            var videosArr = [Video]()
            if let items = JSON["items"] as? NSArray {
            for video in items {
             let vidObj = Video()
             vidObj.videoID = video.valueForKeyPath("snippet.resourceId.videoId") as! String
             vidObj.videoTitle = video.valueForKeyPath("snippet.title") as! String
             vidObj.videoDescription = video.valueForKeyPath("snippet.description") as! String
             vidObj.videoThumbnail = video.valueForKeyPath("snippet.thumbnails.maxres.url") as! String
             videosArr.append(vidObj)
            }
         }
        self.arrayVideos = videosArr
            
            if self.delegate != nil{
                self.delegate?.dataReady()
            }
        
        }
        
        }
       
    }
    
    /*func getVideos() -> [Video]{
        
        
        // create video object
        let video1 = Video()
        video1.videoID = "THMBD3fLO9U"
        video1.videoTitle = "Маша и Медведь : Граница на замке (Серия 12)"
        video1.videoDescription = "Медведь с нетерпением ждёт урожая моркови. Хитрый заяц также поджидает момента, когда можно будет полакомиться морковкой. Медведю приходит в голову гениальная, на первый взгляд, мысль: напустить на зайца-воришку Машу, которая будет стеречь его урожай и ловить нарушителей."
        
        let video2 = Video()
        video2.videoID = "GAvCFugqOYs"
        video2.videoTitle = "Маша и Медведь - Весна пришла (Серия 7)"
        video2.videoDescription = "Медведь просыпается весной, выходит на крыльцо, сладко потягивается и видит медведицу. Он моментально влюбляется и, прихватив букет цветов и конфеты, бежит к ней, но путь ему преграждает Маша. Он пытается избавиться от Маши таким образом, чтобы Медведица ничего не заметила, но Маша всё равно возникает в самые неподходящие моменты. Наконец медведица её замечает и требует от медведя объяснений. Он, стесняясь, пытается объясниться.Медведица предлагает ему сделать выбор - либо Маша, либо она.Медведь не может определиться, и она уходит с другим."
        
        
        let video3 = Video()
        video3.videoID = "os00JDq_rKk"
        video3.videoTitle = "Маша и Медведь - Двое на одного (Серия 36)"
        video3.videoDescription = "К Маше в гости приезжает ее сестрёнка Даша. Внешне они похожи, как две капли воды, но по характеру такие разные! Даша строгая и аккуратная. Маше не терпится поделиться радостью с Медведем, и она ведет Дашу к нему в гости -- знакомиться. И вот тут начинается самое интересное..."
        
        
        let video4 = Video()
        video4.videoID = "jCKO7Pya6S8"
        video4.videoTitle = "Маша и Медведь - Сказка на ночь (Серия 39)"
        video4.videoDescription = "Из-за сильной грозы Маше приходится остаться у Медведя. Но как же отправляться спать без доброй сказки на ночь? Мог ли Медведь предположить, чем обернётся его идея оставить Машу перед телевизором без присмотра?"
        
        
        let video5 = Video()
        video5.videoID = "YXh4Hr0Fl-c"
        video5.videoTitle = "Маша и Медведь - Витамин роста (Серия 30)"
        video5.videoDescription = "Медведь, обходя свой огород, вдруг обнаружил, что его тюльпаны совсем зачахли. В этот момент мимо прогуливались Гималайский медведь-культурист и Медведица. Из-за насмешек давнего соперника Медведь решает создать супервитамин роста. Он запирается в кладовке, переоборудованной в химическую лабораторию. Но тут появляется Маша, а ей уж точно нужно добраться до витамина роста и опробовать его..."
        
        videos.append(video1)
        videos.append(video2)
        videos.append(video3)
        videos.append(video4)
        videos.append(video5)
        
    return videos
    }*/
}

