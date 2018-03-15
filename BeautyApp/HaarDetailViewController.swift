//
//  HaarDetailViewController.swift
//  BeautyApp
//
//  Created by User on 09/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class HaarDetailViewController: UIViewController, YTPlayerViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
    
    @IBOutlet var haarVideo: YTPlayerView!
    @IBOutlet var titelVideoHaar: UILabel!
    @IBOutlet var durationVideoHaar: UILabel!
    @IBOutlet var likesVideoHaar: UILabel!
    @IBOutlet var channelNameHaarVideo: UILabel!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var starButton: UIButton!
    
    
    var numberOfLikes: Int!
    var userID: String!
    var isLiked: Bool = false
    var videoIDString : String?
    var tHaar = ""
    var dHaar = ""
    var lHaar: Int!
    var cHaar = ""
    
    
    @IBAction func loveButtonTapped(_ sender: UIButton) {
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
        let videoQuery = PFQuery (className: "Tutorials")
        videoQuery.whereKey("videoIDParse", equalTo: videoIDString!)
        videoQuery.getFirstObjectInBackground { (object, error) -> Void in
            if (object != nil) {
                print(object)
                let like = object!["like"] as? PFObject
                print(like)
                let image = UIImage(named: "fullLikeTrans.png")
                sender.setImage(image, for: UIControlState())
                let pObj = object!
                let votes = pObj.object(forKey: "numberOfLikes") as! Int
                pObj.setObject(votes + 1, forKey: "numberOfLikes")
                pObj.saveInBackground()
                
                
                if like == nil {
                    let likeObject = Like(video: object!, user: PFUser.current()!)
                    likeObject.saveInBackground(block: { (succes, error) -> Void in
                        if succes {
                            
                            object!["like"] = likeObject
                            object!.saveInBackground()
                            
                        }
                    })
                    
                    
                } else {
                    print("testing")
                    let image = UIImage(named: "EmptyLikeTrans.png")
                    sender.setImage(image, for: UIControlState())
                    pObj.setObject(votes - 1, forKey: "numberOfLikes")
                    pObj.saveInBackground()
                    
                    object!.remove(forKey: "like")
                    object!.saveInBackground()
                    like!.deleteInBackground()
                }
                }
                
            }
            
        }
    }
    @IBAction func favoriteButtonPressed(_ sender: AnyObject) {
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
            let query = PFQuery(className: "_User")
            query.whereKey("email", equalTo: (PFUser.current()!.email)!)
            query.getFirstObjectInBackground { (object: PFObject?, error: NSError?) -> Void in
                if error == nil {
                    query.whereKey("Favorites", equalTo: self.videoIDString!)
                    query.getFirstObjectInBackground { (objects: PFObject?, error: NSError?) -> Void in
                        if objects == nil {
                            object!.add(self.videoIDString!, forKey: "Favorites")
                            object!.saveInBackground{
                                (success: Bool, error: NSError?)-> Void in
                                if (success) {
                                    print("saved \(self.tHaar) to favorites")
                                    let image = UIImage(named: "fullFavorite.png")
                                    sender.setImage(image, for: UIControlState())
                                }
                                else {
                                    print("error not saved to favorites")
                                }
                            }
                        } else {
                            if objects != nil {
                                let image = UIImage(named: "EmptyFavorite.png")
                                sender.setImage(image, for: UIControlState())
                                objects!.remove(forKey: "like")
                                objects!.saveInBackground()
                                objects!.deleteInBackground()
                            }
                        }
                    }
                } else {
                    print("error not saved to favorites cause it gives nil")
                    
                }
            }
        }
    }
    
    func getLove () {
        
     let getLquery = PFQuery (className: "Tutorials")
        getLquery.whereKey("videoIDParse", equalTo: videoIDString!)
        getLquery.getFirstObjectInBackground { (objectLove, error) -> Void in
            if objectLove != nil {
        let love = objectLove!["numberOfLikes"] as! Int
                self.likesVideoHaar.text = "\(love)"
           
                
             
            }
        }
        
        
    }
    
    
    
    
    
    func checkTheID() {
        let idQuery = PFQuery(className: "Tutorials")
        idQuery.whereKey("videoIDParse", equalTo: videoIDString!)
        idQuery.findObjectsInBackground { (objects: [PFObject]?, error: NSError?) -> Void in
            if objects?.count == 0 {
                // The find is zero:
                print("Nothing found begin save:")
                let makeID = PFObject(className: "Tutorials")
                makeID["numberOfLikes"] = 0
                makeID["videoTitle"] = self.tHaar
                makeID["videoIDParse"] = self.videoIDString
                makeID["Soort"] = "Haar"
                makeID.saveInBackground {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        print("saved")
                    } else {
                        print("Something is wrong")
                    }
                }
            } else {
                // Log details of the failure
                print("Allready exists")
                
            }
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let query = PFQuery (className: "_User")
        query.whereKey("Favorites", equalTo: self.videoIDString!)
        query.getFirstObjectInBackground { (object, error) -> Void in
            if object != nil {
                let image = UIImage(named: "fullFavorite.png")
                self.starButton.setImage(image, for: UIControlState())
            }
            let query = PFQuery (className: "Tutorials")
            query.whereKey("videoIDParse", equalTo: self.videoIDString!)
            query.getFirstObjectInBackground { (object, error) -> Void in
                if (object != nil) {
                    print(object)
                    let like = object!["like"] as? PFObject
                    print(like)
                    
                    if like != nil {
                        let image = UIImage(named: "fullLikeTrans.png")
                        self.heartButton.setImage(image, for: UIControlState())
                        print("Like is not empty")
                    } else {
                        let image = UIImage(named: "EmptyLikeTrans.png")
                        self.heartButton.setImage(image, for: UIControlState())
                        print("Like is empty")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad () {
        super.viewDidLoad()
        titelVideoHaar.text = tHaar
        durationVideoHaar.text = dHaar
        channelNameHaarVideo.text = cHaar
        getLove()
        checkTheID()
        haarVideo.load(withVideoId: videoIDString)
        
        let query = PFQuery (className: "Tutorials")
        query.whereKey("videoIDParse", equalTo: videoIDString!)
        query.getFirstObjectInBackground { (object, error) -> Void in
            if (object != nil) {
                print(object)
                let like = object!["like"] as? PFObject
                print(like)
                
                if like != nil {
                    let image = UIImage(named: "fullLikeTrans.png")
                    self.heartButton.setImage(image, for: UIControlState())
                    print("Like is not empty")
                    
                }
            }
        }
    }
}


