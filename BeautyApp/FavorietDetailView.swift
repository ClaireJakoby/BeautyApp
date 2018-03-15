////
////  FavorietDetailView.swift
////  BeautyApp
////
////  Created by Claire Jakoby on 29-03-16.
////  Copyright © 2016 Jasper Stokman. All rights reserved.
////
//
//import UIKit
//
//
//class FavorietDetailViewController: UIViewController, YTPlayerViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
//    
//    
//    @IBOutlet var favorietVideo: YTPlayerView!
//    @IBOutlet var titelFavoriet: UILabel!
//    @IBOutlet var channelIDFavoriet: UILabel!
//
//    @IBOutlet var starButton: UIButton!
//    @IBOutlet var hartButton: UIButton!
//    
//    var videoIDString : String?
//    var tFavoriet = ""
//    var lFavoriet = ""
//    var cFavoriet = ""
//    
//    @IBAction func favoriteButtonPressed(sender: AnyObject) {
//        if PFUser.currentUser() == nil {
//            let loginViewController = LoginViewController()
//            loginViewController.delegate = self
//            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .PasswordForgotten, .SignUpButton, .Facebook, .Twitter, .DismissButton]
//            loginViewController.emailAsUsername = true
//            loginViewController.signUpController?.delegate = self
//            loginViewController.emailAsUsername = true
//            loginViewController.signUpController?.emailAsUsername = true
//            self.presentViewController(loginViewController, animated: false, completion: nil)
//        } else {
//            let query = PFQuery(className: "_User")
//            query.whereKey("email", equalTo: (PFUser.currentUser()!.email)!)
//            query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
//                if error == nil {
//                    query.whereKey("Favorites", equalTo: self.videoIDString!)
//                    query.getFirstObjectInBackgroundWithBlock { (objects: PFObject?, error: NSError?) -> Void in
//                        if objects == nil {
//                            object!.addObject(self.videoIDString!, forKey: "Favorites")
//                            object!.saveInBackgroundWithBlock{
//                                (success: Bool, error: NSError?)-> Void in
//                                if (success) {
//                                    print("saved \(self.tFavoriet) to favorites")
//                                    let image = UIImage(named: "fullFavorite.png")
//                                    sender.setImage(image, forState: UIControlState.Normal)
//                                }
//                                else {
//                                    print("error not saved to favorites")
//                                }
//                            }
//                        } else {
//                            if objects != nil {
//                                let image = UIImage(named: "EmptyFavorite.png")
//                                sender.setImage(image, forState: UIControlState.Normal)
//                                objects!.removeObjectForKey("like")
//                                objects!.saveInBackground()
//                                objects!.deleteInBackground()
//                                
//                            }
//                        }
//                    }
//                } else {
//                    print("error not saved to favorites cause it gives nil")
//                    
//                }
//            }
//        }
//    }
//    
//    func presentLoggedInAlert() {
//        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to Beau-It-Yourself", preferredStyle: .Alert)
//        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//        
//        alertController.addAction(OKAction)
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//        presentLoggedInAlert()
//    }
//    
//    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//        presentLoggedInAlert()
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        let query = PFQuery (className: "_User")
//        query.whereKey("Favorites", equalTo: self.videoIDString!)
//        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
//            if object != nil {
//                let image = UIImage(named: "fullFavorite.png")
//                self.starButton.setImage(image, forState: UIControlState.Normal)
//            }
//        }
//    }
//    
//    override func viewDidLoad () {
//        super.viewDidLoad()
//        titelFavoriet.text = tFavoriet
//      //  likesVideoMakeUp.text = lFavoriet
//        channelIDFavoriet.text = cFavoriet
//        favorietVideo.loadWithVideoId(videoIDString)
//        
//    }
//}