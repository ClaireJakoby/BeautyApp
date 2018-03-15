//
//  SignUpViewController.swift
//  BeautyApp
//
//  Created by User on 07/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class SignUpViewController : PFSignUpViewController {
    
    var backgroundImage : UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "MakeUp.jpg"))
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        signUpView!.insertSubview(backgroundImage, at: 0)
        
        // remove the parse Logo
        let logo = UILabel()
        logo.text = "Beau-It-Yourself"
        logo.textColor = UIColor.white
        logo.font = UIFont(name: "Pacifico", size: 50)
        logo.shadowColor = UIColor.lightGray
        logo.shadowOffset = CGSize(width: 2, height: 2)
        signUpView?.logo = logo
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        // change dismiss button to say 'Already signed up?'
        signUpView?.dismissButton!.setTitle("Already signed up?", for: UIControlState())
        signUpView?.dismissButton!.setImage(nil, for: UIControlState())
        
        // make the background of the login button pop more
        signUpView?.dismissButton?.setBackgroundImage(nil, for: UIControlState())
        signUpView?.dismissButton?.backgroundColor = UIColor(red: 46/255, green: 174/255, blue: 170/255, alpha: 0.8)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRect( x: 0,  y: 0,  width: signUpView!.frame.width,  height: signUpView!.frame.height)
        
        // position logo at top with larger frame
        signUpView!.logo!.sizeToFit()
        let logoFrame = signUpView!.logo!.frame
        signUpView!.logo!.frame = CGRect(x: logoFrame.origin.x, y: signUpView!.usernameField!.frame.origin.y - logoFrame.height - 16, width: signUpView!.frame.width,  height: logoFrame.height)
        
        // re-layout out dismiss button to be below sign
        let dismissButtonFrame = signUpView!.dismissButton!.frame
        signUpView?.dismissButton!.frame = CGRect(x: 0, y: signUpView!.signUpButton!.frame.origin.y + signUpView!.signUpButton!.frame.height + 16.0,  width: signUpView!.frame.width,  height: dismissButtonFrame.height)
    }
    
}
