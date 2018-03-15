//
//  DIYTableViewController.swift
//  BeautyApp
//
//  Created by  Sayed on 15-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit
class DIYTableViewController: UITableViewController {
    
    var diyNames = ["Thick Hair", "Dry Hair Shampoo", "Defy Time", "Anti age yourself", "Oil Treatment for Hair", "Hair Routine Habits", "Avocado skin", "Masks DIY", "Lose the Puffy Eyes", "Eyebrow Frameworks", " DIY Foothbath", "Pedicure 101", "Dry Brush your skin", "Coffee CoCo Scrub loving", "Lavender Lotion Bars", "Wax it yourself", "Natural DIY Teeth Whitening", "Shaving Scrub", "Growth serum Eyelashes", "Manicure 101", "The oil cleanse method", " Natural Feminine Cleanser", "Lemon Home Remedies", "Sunscreen Do it Yourself", "Winter Wonderland Skincare", "Night Treament Vitamine E"]
//    var subTitlesNames = ["The Thicker the Better", "Dust it off and try me again", "Melting the Age away", "It must have been the Oil, that got it like that", "Hairy Habits to live by", "One avocado for the skin please", "Power Puff eyes", "Eyebrows on another Level", "Footbath from Heaven", "What, Do people even care about their feet?", "Bristly Habits", "When coconuts and Coffee make a baby", "For lovers of Lavender", "Hairy Harriette is not my Name", "Smile so white, Toothfairy going to pay me more at night", "How to save your Shaving on Bondi beach. (ps. Bring the coconuts with you)","When I gave people a reason to ask me if I had Lash Extensions", "How to make my Nails look polished without effort", "Greasy clean as one can be", "Match your femininity with this feminine care", "It's so Lemontastic Fantastic", "Lovers of sun, this ones for You", "Brace yourself, Chappy winter Times are coming", "I need some Good Vitamine E loving, Put it on me tonight"]
    var diyImages = ["DIY1.jpg","DIY2.jpg","DIY3.jpg","DIY4.jpg", "DIY5.jpeg", "DIY6.jpg","DIY7.jpg","DIY8.jpg","DIY9.jpg","DIY10.jpg","DIY11.jpeg","DIY12.jpg","DIY13.jpeg","DIY14.jpg","DIY15.jpg","DIY16.jpg","DIY17.jpg","DIY18.jpg","oilclean.jpeg","DIY20.jpg","lemon.jpg","DIY22.jpg","DIY23.jpg", "DIY24.jpg"]
    
    
    var allDIY = [PFObject]()
    var diyDetails = DIYDetailViewController()

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diyNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "diyCell", for: indexPath) as! DIYTableCell
        
        // Configure the cell...
        cell.nameLabel.text = diyNames[indexPath.row] 
 //      cell.subTitleLabel.text = subTitlesNames[indexPath.row]
       cell.thumbnailImageView.image = UIImage(named: diyImages[indexPath.row])

        
        
        
        
        return cell
    }
    
  

    
    func loadObjectsFromParse() {
        
        let query = PFQuery(className: "DoITYourself")
        query.findObjectsInBackground { (objects: [PFObject]?, error: NSError?) -> Void in
            
            self.allDIY = objects!
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diy = self.storyboard?.instantiateViewController(withIdentifier: "DIYDetail") as! DIYDetailViewController
        
        let info =  allDIY[indexPath.row]
        diy.lLabel = info.value(forKey: "Titel") as! String
        diy.bIdeaal = info.value(forKey: "Informatie") as! String
        
    
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

