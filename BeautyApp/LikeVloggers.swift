//
//  LikeVloggers.swift
//  BeautyApp
//
//  Created by Claire Jakoby on 30-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class LikeVloggers : PFObject {
    
    override init() {
        super.init()
    }
    
    init(vlogger: PFObject, user: PFUser) {
        super.init(className: "LikeVlogger")
        
        self["user"] = user
        self["vlogger"] = vlogger

    }
}