//
//  VloggersTableView.swift
//  BeautyApp
//
//  Created by Claire Jakoby on 30-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class VloggersTableView: UITableViewController {
    
    var allVloggers = [PFObject]()
    var vloggerDetails = VloggersDetailViewController()
    

    
    func loadObjectsFromParse() {
        let query = PFQuery(className:"Vloggers")
        query.order(byDescending: "NumberOfLikes")
        query.findObjectsInBackground { (objects: [PFObject]?, error: NSError?) -> Void in
            self.allVloggers = objects!
            self.tableView.reloadData()
            } as! ([PFObject]?, Error?) -> Void
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allVloggers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vloggersCell") as! VloggersItemCell
        
        let vloggers = allVloggers[indexPath.row]
        cell.channelIDLabel.text = vloggers.value(forKey: "ChannelID") as? String
        cell.realNameLabel.text = vloggers.value(forKey: "NameVlogger") as? String
        let lid = vloggers.value(forKey: "LidSinds") as! String
        cell.lidSindsLabel.text = "Lid sinds: \(lid)"
        let love = vloggers.value(forKey: "NumberOfLikes") as! Int
        cell.lovesLabel.text = "Loves given: \(love)"
        
        let parseImage = vloggers.value(forKeyPath: "ProfilePicture") as? PFFile
        cell.channelPhoto.file = parseImage
        cell.channelPhoto.loadInBackground()
        
        cell.channelPhoto.layer.cornerRadius = cell.channelPhoto.frame.size.width / 2;
        cell.channelPhoto.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vloggerDetails = self.storyboard?.instantiateViewController(withIdentifier: "vlogger") as! VloggersDetailViewController
        let vloggersDetail = allVloggers[indexPath.row]
        vloggerDetails.vChannelID = vloggersDetail.value(forKey: "ChannelID") as! String
        vloggerDetails.vRealName = vloggersDetail.value(forKey: "NameVlogger") as! String
        vloggerDetails.vBeschrijving = vloggersDetail.value(forKey: "Beschrijving") as! String
        vloggerDetails.vLidSinds = vloggersDetail.value(forKey: "LidSinds") as! String
        vloggerDetails.videoIDString = vloggersDetail.value(forKey: "VideoIDVlogger") as? String
        
        self.navigationController?.pushViewController(vloggerDetails, animated: true)
      //  vloggerDetails.loadView()
    }

    override func viewDidLoad() {
        self.loadObjectsFromParse()
        super.viewDidLoad()
        
    }
}
