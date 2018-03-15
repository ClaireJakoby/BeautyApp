//
//  HuidTableView.swift
//  BeautyApp
//
//  Created by User on 09/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class HuidTableViewController: UITableViewController {
    
    var arr = []
    var love = HuidItemCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TAAYouTubeWrapper.videos(forPlaylist: "HuidVideos", forChannel: "UCN9SBwt2m1O4LxpOYBpwCQQ") { (succeeded, videos, error) -> Void in
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHuid") as! HuidItemCell
        
        let videoObject = arr[indexPath.row] as! GTLYouTubeVideo
        
        let videoTitle = videoObject.snippet.title
        let imageUrl = videoObject.snippet.thumbnails.medium.url
        let url = URL(string: imageUrl!)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        
        cell.thumbnailHuid.image = image
        cell.titelLabel.text = videoTitle
        
        
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
        let huidVideoDetails = self.storyboard?.instantiateViewController(withIdentifier: "huidVideo") as! HuidDetailViewController
        let info = arr[indexPath.row] as! GTLYouTubeVideo
        
        print(info.snippet.title)
        print(info.contentDetails.duration)
        print(info.snippet.channelTitle)
        print(info.identifier)
        
        huidVideoDetails.tHuid = info.snippet.title
        huidVideoDetails.cHuid = info.snippet.channelTitle
        let videoID = info.identifier
        huidVideoDetails.videoIDString = videoID
        
        let getLquery = PFQuery (className: "Tutorials")
        getLquery.whereKey("videoTitle", equalTo: huidVideoDetails.tHuid)
        getLquery.getFirstObjectInBackground { (objectLove, error) -> Void in
            if objectLove != nil {
                let duration = objectLove!["Duration"] as! String
                huidVideoDetails.dHuid = duration
        
        self.navigationController?.pushViewController(huidVideoDetails, animated: true)
            }
        }
    }
}
