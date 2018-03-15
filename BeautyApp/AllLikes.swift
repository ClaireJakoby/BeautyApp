////
////  FavoritesOfLikes.swift
////  BeautyApp
////
////  Created by User on 30/03/16.
////  Copyright © 2016 Jasper Stokman. All rights reserved.
////
//
//import UIKit
//
//class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//var parseArray = [PFObject]()
//
//// MARK:  Functions
//
//    @IBOutlet var LikesTableView: UITableView!
//    
//    
//func getDataFromParse() {
//    let query = PFQuery(className:"Tutorials")
//    query.orderByDescending("numberOfLikes")
//    query.findObjectsInBackgroundWithBlock { (Objectstore: [PFObject]?,error: NSError?) -> Void in
//        if error == nil {
//            self.parseArray = Objectstore!
//            self.LikesTableView.reloadData()
//            
//        } else if let error = error {
//            print(error)
//        }
//    }
//}
//
//
//func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // Hier word er getelt in de array om te kijken hoeveel cellen er aangemaakt moeten worden
//    return parseArray.count
//    
//}
//
//
//func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:  indexPath) as! Cell
////    
////    let parseData = parseArray[indexPath.row]
////    
////    cell.Label.text = parseData.valueForKey("Like") as? String
////    cell.Label.text = parseData.valueForKey("") as? String
////    cell.Label.text = parseData.valueForKey("") as? String
////    cell.Cell.file = parseData.valueForKey("") as? PFFile
////    
////    cell.imageViewCell.loadInBackground()
////    
////    return cell
//    
//}
//
//
//func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    indexPath.row
//    
//    if indexPath.row == parseArray.count {
//        
//    } else {
//        
//        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailTableViewController") as!
//        
////        detailVC.parseObject = parseArray[indexPath.row]
//        
////        self.navigationController?.pushViewController(detailVC, animated: true)
////    }
//    
//}
//    }
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    getDataFromParse()
//    
//}
//
//override func viewWillAppear(animated: Bool) {
//    getDataFromParse()
//    print("Table view controller word geladen")
//}
//
//}