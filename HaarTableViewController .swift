//
//  HaarTableViewController .swift
//  BeautyApp
//
//  Created by User on 09/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class HaarTableViewController: UITableViewController {
    
    var arr = []
    var aallInfoHaar = HaarDetailViewController()
    var videoHaar = YTPlayerView()
    var numberOfLikes: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TAAYouTubeWrapper.videos(forPlaylist: "HaarVideos", forChannel: "UCN9SBwt2m1O4LxpOYBpwCQQ") { (succeeded, videos, error) -> Void in
            
            if videos != nil {
                self.arr = videos!
                self.tableView.reloadData()
                
                
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHaar") as! HaarItemCell
        
        let videoObject = arr[indexPath.row] as! GTLYouTubeVideo
        
        let videoTitle = videoObject.snippet.title
        let imageUrl = videoObject.snippet.thumbnails.medium.url
        let url = URL(string: imageUrl!)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        
        
        cell.thumbnailHaar.image = image
        cell.titelLabel.text = videoTitle
        cell.durationLabel.text = videoObject.contentDetails.duration
        
        let getLquery = PFQuery (className: "Tutorials")
        getLquery.whereKey("videoTitle", equalTo: videoTitle!)
        getLquery.getFirstObjectInBackground { (objectLove, error) -> Void in
            if objectLove != nil {
                let love = objectLove!["numberOfLikes"] as! Int
                cell.loveLabel.text  = "\(love)"
                let duration = objectLove!["Duration"] as! String
                cell.durationLabel.text = duration
                
            }
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let haarVideoDetails = self.storyboard?.instantiateViewController(withIdentifier: "haarVideo") as! HaarDetailViewController
        let info = arr[indexPath.row] as! GTLYouTubeVideo
        
        print(info.snippet.title)
        print(info.contentDetails.duration)
        print(info.snippet.channelTitle)
        print(info.identifier)
        
        haarVideoDetails.tHaar = info.snippet.title
        haarVideoDetails.cHaar = info.snippet.channelTitle
        let videoID = info.identifier
        haarVideoDetails.videoIDString = videoID
        let getLquery = PFQuery (className: "Tutorials")
        getLquery.whereKey("videoTitle", equalTo: haarVideoDetails.tHaar)
        getLquery.getFirstObjectInBackground { (objectLove, error) -> Void in
            if objectLove != nil {
                let duration = objectLove!["Duration"] as! String
                haarVideoDetails.dHaar = duration
                
        self.navigationController?.pushViewController(haarVideoDetails, animated: true)
        
    }
    
}
    }
}





