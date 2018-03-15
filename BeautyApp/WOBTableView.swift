//
//  WOBTableView.swift
//  Try Tableview
//
//  Created by Claire Jakoby on 08-03-16.
//  Copyright © 2016 Claire Jakoby. All rights reserved.
//

import UIKit


class WOBTableView: UITableViewController, UINavigationControllerDelegate {
    
    var allLands = [PFObject]()
    var wobDetails = WOBDetailView()

    override func viewDidLoad() {
        loadObjectsFromParse()
    }
    
    func loadObjectsFromParse() {
        
        let query = PFQuery(className: "WOB")
        query.findObjectsInBackground { (objects: [PFObject]?, error: NSError?) -> Void in
            
            self.allLands = objects!
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLands.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WOBCell") as! WOBTableCell
        
        let lands = allLands[indexPath.row]
        cell.nameLabel.text = lands.value(forKey: "Land") as? String
        let parseImage = lands.value(forKeyPath: "CellFoto") as? PFFile
        cell.photoImageView.file = parseImage
        cell.photoImageView.loadInBackground()
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wob = self.storyboard?.instantiateViewController(withIdentifier: "wobLand") as! WOBDetailView
        
        let info = allLands[indexPath.row]
        wob.lLabel = info.value(forKey: "Land") as! String
        wob.bIdeaal = info.value(forKey: "Info") as! String
        
        
        if let pfImage = info["Banner"] as? PFFile {
            pfImage.getDataInBackground {
                (imageData: Data?, error: NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    wob.bView = image!
                    if image != nil {
                        self.navigationController?.pushViewController(wob, animated: true)
                    }
                }
            }
        }
    }
}
