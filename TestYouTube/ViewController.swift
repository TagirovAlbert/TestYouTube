//
//  ViewController.swift
//  TestYouTube
//
//  Created by Albert Tagirov on 25.07.16.
//  Copyright © 2016 Albert Tagirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VideoModelDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var videos: [Video] = [Video]()
    var selectedVideo:Video?
    let model:VideoModel = VideoModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        model.getFeedVideos()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.tableView.frame.width / 320) * 180
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")
        let viTitle = cell?.viewWithTag(2) as! UILabel
        viTitle.text = videos[indexPath.row].videoTitle
        // construct the video thumbnail url
        let videoThumbnailUrlString = videos[indexPath.row].videoThumbnail
        // create NSURL object
        let videoThumbnailUrl = NSURL(string: videoThumbnailUrlString)
        
        if videoThumbnailUrl != nil{
            
          // create NSURLRequest
          let videoRequest = NSURLRequest(URL: videoThumbnailUrl!)
          // create NSURLSession
          let videoSession = NSURLSession.sharedSession()
            let dataTask = videoSession.dataTaskWithRequest(videoRequest, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    let imageView = cell?.viewWithTag(1) as! UIImageView
                    imageView.image = UIImage(data: data!)
                    
                })
                
            })
            
            dataTask.resume()
            
        }
        
        
        return cell!
    }
    
    //MARK: - VideoModelDelegate methods
    func dataReady() {
        self.videos = model.arrayVideos
        self.tableView.reloadData()
    }
    
    //MARK: - TableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedVideo = videos[indexPath.row]
        self.performSegueWithIdentifier("goToDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! VideoDetailViewController
        detailViewController.selectedVideo = self.selectedVideo
        
    }


}

