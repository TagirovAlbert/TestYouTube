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
    var myQuest: NSArray?
    let model:VideoModel = VideoModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        model.getFeedVideos()
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.tableView.frame.width / 320) * 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")
        let viTitle = cell?.viewWithTag(2) as! UILabel
        viTitle.text = videos[(indexPath as NSIndexPath).row].title
        // construct the video thumbnail url
        let videoThumbnailUrlString = videos[(indexPath as NSIndexPath).row].thumbnailMax
        // create NSURL object
        let videoThumbnailUrl = URL(string: videoThumbnailUrlString)
        
        if videoThumbnailUrl != nil{
            
                // create NSURLRequest
                let videoRequest = URLRequest(url: videoThumbnailUrl!)
                // create NSURLSession
                let videoSession = URLSession.shared
                let dataTask = videoSession.dataTask(with: videoRequest, completionHandler: { (data, response, error) in
                    
                    DispatchQueue.main.async(execute: {
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
    
    func imageSave(){
        
    }
    
    //MARK: - TableViewDelegate methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail"{
            let indexPaths = self.tableView.indexPathsForSelectedRows
            let indexPath  = indexPaths?[0]
            let detailViewController = segue.destination as! VideoDetailViewController
            detailViewController.selectedVideo = self.videos[(indexPath?.row)!]
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    


}

