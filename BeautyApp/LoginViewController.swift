//
//  LoginViewController.swift
//  BeautyApp
//
//  Created by User on 03/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class LoginViewController : PFLogInViewController {
    
    var backgroundImage : UIImageView!;

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "MakeUp.jpg"))
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.logInView!.insertSubview(backgroundImage, at: 0)
        
        // remove the parse default Logo
        let logo = UILabel()
        logo.text = "Beau-It-Yourself"
        logo.textColor = UIColor.white
        logo.font = UIFont(name: "Pacifico", size: 50)
        logo.shadowColor = UIColor.lightGray
        logo.shadowOffset = CGSize(width: 2, height: 2)
        logInView?.logo = logo
        
        // make the background of the login button pop more
        logInView?.logInButton?.setBackgroundImage(nil, for: UIControlState())
        logInView?.logInButton?.backgroundColor = UIColor(red: 46/255, green: 174/255, blue: 170/255, alpha: 0.8)
        
        logInView?.passwordForgottenButton?.setTitleColor(UIColor.white, for: UIControlState())
        
        logInView?.dismissButton?.isHidden = false 
        
        self.signUpController = SignUpViewController()

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRect( x: 0,  y: 0,  width: self.logInView!.frame.width,  height: self.logInView!.frame.height)
        
        // position logo at top with larger frame
        logInView!.logo!.sizeToFit()
        let logoFrame = logInView!.logo!.frame
        logInView!.logo!.frame = CGRect(x: logoFrame.origin.x, y: logInView!.usernameField!.frame.origin.y - logoFrame.height - 16, width: logInView!.frame.width,  height: logoFrame.height)
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    
}
