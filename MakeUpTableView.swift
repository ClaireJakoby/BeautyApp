//
//  MakeUpTableView.swift
//  BeautyApp
//
//  Created by User on 09/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class MakeUpTableViewController: UITableViewController {
    
    var arr = []
    var allInfo = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TAAYouTubeWrapper.videos(forPlaylist: "MakeupVideos", forChannel: "UCN9SBwt2m1O4LxpOYBpwCQQ") { (succeeded, videos, error) -> Void in
            
            if videos != nil {
                self.arr = videos!
                self.tableView.reloadData()
            }
        }
    }
    
    func loadObjectsFromParse() {
        let query = PFQuery(className: "Tutorials")
        query.findObjectsInBackground { (objects: [PFObject]?, error: NSError?) -> Void in
            
            self.allInfo = objects!
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMakeUp") as! MakeUpItemCell
        
        let videoObject = arr[indexPath.row] as! GTLYouTubeVideo
        
        let videoTitle = videoObject.snippet.title
        let imageUrl = videoObject.snippet.thumbnails.medium.url
        let url = URL(string: imageUrl!)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        
        cell.thumbnailMakeUp.image = image
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
        let makeUpVideoDetails = self.storyboard?.instantiateViewController(withIdentifier: "makeUpVideo") as! MakeUpDetailViewController
        let info = arr[indexPath.row] as! GTLYouTubeVideo
        
        makeUpVideoDetails.tMakeUp = info.snippet.title
        makeUpVideoDetails.cMakeUp = info.snippet.channelTitle
        
        let videoID = info.identifier
        makeUpVideoDetails.videoIDString = videoID
        
        let getLquery = PFQuery (className: "Tutorials")
        getLquery.whereKey("videoTitle", equalTo: makeUpVideoDetails.tMakeUp)
        getLquery.getFirstObjectInBackground { (objectLove, error) -> Void in
            if objectLove != nil {
                let duration = objectLove!["Duration"] as! String
                makeUpVideoDetails.dMakeUp = duration
        
        self.navigationController?.pushViewController(makeUpVideoDetails, animated: true)
                }
            }
        }
    }
    



