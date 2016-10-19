//
//  VideoDetailViewController.swift
//  TestYouTube
//
//  Created by Albert Tagirov on 29.07.16.
//  Copyright © 2016 Albert Tagirov. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {

    
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    var selectedVideo:Video?
    
    override func viewDidLoad(){
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let vid = self.selectedVideo{
            self.videoTitle.text = selectedVideo?.title
            self.videoDescription.text = selectedVideo?.description
            
            let width = self.view.frame.width
            let height = width/320 * 180
            self.webViewHeightConstraint.constant = height
           /* let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + String(describing: height) + "\" width=\"" + String(describing: width) + "\" src=\"http://www.youtube.com/embed/" + vid.videoId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            */
            let embededHTML = "<!DOCTYPE html><html><head><style type=\"text/css\"> body { margin: 0; padding: 0; } body, html { height: 100%; width: 100%; } </style> </head> <body> <iframe id=\"player\" type=\"text/html\" width=\"\(String(describing: width))\" height=\"\(String(describing: height))\" src=\"http://www.youtube.com/embed/\(vid.videoId)?enablejsapi=1&playsinline=1\" frameborder=\"0\"></iframe> <script> var tag = document.createElement('script'); tag.src = \"https://www.youtube.com/iframe_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubeIframeAPIReady() { player = new YT.Player('player', { events: { 'onReady': onPlayerReady } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body></html>"

            self.webView.mediaPlaybackAllowsAirPlay = true
            self.webView.allowsInlineMediaPlayback = true
            
            self.webView.mediaPlaybackRequiresUserAction = false
            self.webView.loadHTMLString(embededHTML, baseURL: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
