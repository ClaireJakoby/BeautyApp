//
//  HomeMenuViewController.swift
//  BeautyApp
//
//  Created by Claire Jakoby on 28-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class HomeMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true

    
}
}
