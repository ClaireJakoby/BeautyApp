////
////  aboutUsViewController.swift
////  BeautyApp
////
////  Created by  Sayed on 24-03-16.
////  Copyright © 2016 Jasper Stokman. All rights reserved.
////
//
//
//import UIKit
//
//class AboutUsViewController: UIViewController {
//    
//    @IBOutlet weak var image: UIImageView!
//    
//    @IBOutlet var yearLabel: UILabel!
//    
//    @IBOutlet var monthLabel: UILabel!
//    
//    @IBOutlet var dayLabel: UILabel!
//    
//    @IBOutlet var hourLabel: UILabel!
//    
//    @IBOutlet var minuteLabel: UILabel!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.image.layer.cornerRadius = self.image.frame.height/2
//        self.image.layer.borderWidth = 2
//        self.image.layer.borderColor = UIColor.whiteColor().CGColor
//        self.image.clipsToBounds = true
//        
//        let date = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
//        
//        let year =  components.year
//        let month = components.month
//        let day = components.day
//        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
//        let minute = NSCalendar.currentCalendar().component(.Minute, fromDate: NSDate())
//        
//        yearLabel.text = String(year)
//        monthLabel.text = String(month)
//        dayLabel.text = String(day)
//        hourLabel.text = String(hour)
//        minuteLabel.text = String(minute)
//    }
//    
//    
//
//}
