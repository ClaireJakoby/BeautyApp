//
//  TabBarController.swift
//  BeautyApp
//
//  Created by Supervisor on 01-04-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation

class TabbarController: UITabBarController, UITabBarControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        
        //
        //        if  let arrayOfTabBarItems = self.tabBar.items as! AnyObject as? NSArray,tabBarItem = arrayOfTabBarItems[1] as? UITabBarItem {
        //            tabBarItem.enabled = false
        //
        //        }
        //
        self.tabBarController?.selectedIndex = 2
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        if item.tag == 10 {
            print("selected")
            alertProfiel()
//            item.enabled = false
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        print("received the click")
    }
    
    
    
    //    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) -> Bool {
    //
    //        if (tabBarController.selectedIndex == 1) {
    ////
    ////            let viewController:SelectALogoViewController! = viewController as? SelectALogoViewController
    ////            viewController.delegate=self
    ////
    ////            if pickedImage != nil {
    ////
    ////                viewController.pickedImage = pickedImage
    ////            }
    //
    //            print("Yes")
    //        }
    //
    //        print("Yes")
    //
    //
    //        return true
    //
    //    }
    
    func alertProfiel () {
        
        let alertControllert = UIAlertController(title: nil, message: "Before you create a profilepage, you need to login", preferredStyle: .actionSheet)
        
        let cancelActions = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }
        
        let OkAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            if PFUser.current() == nil {
                let loginViewController = LoginViewController()
                loginViewController.delegate = self
                loginViewController.fields = [.usernameAndPassword, .logInButton, .passwordForgotten, .signUpButton, .facebook, .twitter, .dismissButton]
                loginViewController.emailAsUsername = true
                loginViewController.signUpController?.delegate = self
                loginViewController.emailAsUsername = true
                loginViewController.signUpController?.emailAsUsername = true
                self.present(loginViewController, animated: false, completion: nil)
            } else {
                self.presentLoggedInAlert()
            }
            
            
        }
        alertControllert.addAction(OkAction)
        alertControllert.addAction(cancelActions)
        //        1self.presentViewController(alertControllert, animated: true, completion: nil)
        
        //        let destroyAction = UIAlertAction(title: "Dismiss", style: .Destructive) { (action) in
        //            print (action)
        //        }
        //        alertControllert.addAction(destroyAction)
        self.present(alertControllert, animated: true) {
            
        }
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to Beau-It-Yourself", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        self.dismiss(animated: true, completion: nil)
        presentLoggedInAlert()
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        self.dismiss(animated: true, completion: nil)
        presentLoggedInAlert()
    }
    
}
