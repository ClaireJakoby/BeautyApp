//
//  Like.swift
//  BeautyApp
//
//  Created by User on 25/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class Like : PFObject {
    
    override init() {
        super.init()
    }
    
    init(video: PFObject, user: PFUser) {
        super.init(className: "Like")
        
        self["user"] = user
        self["video"] = video
        
        
        
    }
    
    
    
    
    
    
    
}