//
//  MakeUpDetailViewController.swift
//  BeautyApp
//
//  Created by User on 09/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class MakeUpDetailViewController: UIViewController, YTPlayerViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
    
    
    @IBOutlet var makeUpVideo: YTPlayerView!
    @IBOutlet var titelVideoMakeUp: UILabel!
    @IBOutlet var durationVideoMakeUp: UILabel!
    @IBOutlet var likesVideoMakeUp: UILabel!
    @IBOutlet var channelNameMakeUpVideo: UILabel!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var hartButton: UIButton!
    
    var videoIDString : String?
    var tMakeUp = ""
    var dMakeUp = ""
    var lMakeUp = ""
    var cMakeUp = ""
    
    @IBAction func loveButtonTapped(_ sender: AnyObject) {
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
    
    func getLove () {
        
        let getLquery = PFQuery (className: "Tutorials")
        getLquery.whereKey("videoIDParse", equalTo: videoIDString!)
        getLquery.getFirstObjectInBackground { (objectLove, error) -> Void in
            if objectLove != nil {
                let love = objectLove!["numberOfLikes"] as! Int
                self.likesVideoMakeUp.text = "\(love)"
                
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
                makeID["videoTitle"] = self.tMakeUp
                makeID["videoIDParse"] = self.videoIDString
                makeID["Soort"] = "MakeUp"
                makeID.saveInBackground {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        print("saved this videoID to parse: \(self.videoIDString)")
                    } else {
                        print("Something is wrong")
                    }
                }
            } else {
                // Log details of the failure
                print("The videoID is already saved in parse")
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
                                    print("saved \(self.tMakeUp) to favorites")
                                    let image = UIImage(named: "fullFavorite.png")
                                    sender.setImage(image, for: UIControlState())
                                } else {
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
                        self.hartButton.setImage(image, for: UIControlState())
                        print("Like is not empty")
                    } else {
                        let image = UIImage(named: "EmptyLikeTrans.png")
                        self.hartButton.setImage(image, for: UIControlState())
                        print("Like is empty")
                    }
                    
                }
            }
        }
        
    }
    
    override func viewDidLoad () {
        super.viewDidLoad()
        
        titelVideoMakeUp.text = tMakeUp
        durationVideoMakeUp.text = dMakeUp
        likesVideoMakeUp.text = lMakeUp
        channelNameMakeUpVideo.text = cMakeUp
        checkTheID()
        makeUpVideo.load(withVideoId: videoIDString)
        
        let query = PFQuery (className: "Tutorials")
        query.whereKey("videoIDParse", equalTo: videoIDString!)
        query.getFirstObjectInBackground { (object, error) -> Void in
            if (object != nil) {
                print(object)
                let like = object!["like"] as? PFObject
                print(like)
                
                if like != nil {
                    let image = UIImage(named: "fullLikeTrans.png")
                    self.hartButton.setImage(image, for: UIControlState())
                    print("Like is not empty")
                    
                }
            }
        }
    }
}
