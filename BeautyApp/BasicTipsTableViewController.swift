//
//  basicTipsViewController.swift
//  BeautyApp
//
//  Created by  Sayed on 04-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class BasicTipsTableViewController: UITableViewController {
    
    var tipNames = ["Go for a Brisk walk", "Protect Your Skin", "Be Healthy", "Have a beautysleep","Keep Skincare Simple", "Handle your stress Head-on", "Strengthen your hair with protein", "Groom your eyebrows", "Wear Mineral Make-up", "Exfoliate", "Lifestyle","Good Posture","Confidence"]
    
    var tipImages = ["beauty1briskwalk.jpg", "beautyapp2protectskin.jpg", "beautyapp3healthybeauty.jpg", "beautyapp4beautysleep.jpeg", "skincarejuist.jpg", "beautystress.jpg", "beautytipstrenghthait", "beautytipgroomeyebrows.jpeg", "beautytipmineralmakeup", "beautytipexfoliate.jpeg", "beautylifestylesmking.jpeg", "posture.jpg", "beautyapp confidence.jpg"]

    
    var allDIY = [PFObject]()
    var bDetails = BasicTipsDetailViewController()
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BasicTipsItemCell
        
        // Configure the cell...
        cell.nameLabel.text = tipNames[indexPath.row]
       cell.thumbnailImageView.image = UIImage(named: tipImages[indexPath.row])
        
      
       
        
        return cell
    }
    func loadObjectsFromParse() {
        
        let query = PFQuery(className: "BasicTips")
        query.findObjectsInBackground { (objects: [PFObject]?, error: NSError?) -> Void in
            
            self.allDIY = objects!
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diy = self.storyboard?.instantiateViewController(withIdentifier: "BasicD") as! BasicTipsDetailViewController
        
        let info =  allDIY[indexPath.row]
        diy.bIdeaal = info.value(forKey: "Titel") as! String
        diy.lLabel = info.value(forKey: "Informatie") as! String
        
        
        if let pfImage = info["Photo"] as? PFFile {
            pfImage.getDataInBackground {
                (imageData: Data?, error: NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    diy.bView = image!
                    if image != nil {
                        self.navigationController?.pushViewController(diy, animated: true)
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        loadObjectsFromParse()
        
    }
}

