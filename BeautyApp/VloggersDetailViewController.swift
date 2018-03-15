//
//  VloggersDetailViewController.swift
//  BeautyApp
//
//  Created by Claire Jakoby on 30-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class VloggersDetailViewController: UIViewController, YTPlayerViewDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate {
    
    @IBOutlet var vloggerVideo: YTPlayerView!
    @IBOutlet var channelIDDetail: UILabel!
    @IBOutlet var realNameDetail: UILabel!
    @IBOutlet var lidSindsDetail: UILabel!
    @IBOutlet var beschrijvingDetail: UILabel!
    @IBOutlet var hartKnop: UIButton!
    @IBOutlet var loveLabel: UILabel!
    
    var videoIDString : String?
    var vChannelID = ""
    var vRealName = ""
    var vLidSinds = ""
    var vBeschrijving = ""
  
    @IBAction func favorietVlogger(_ sender: AnyObject) {
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
            query.getFirstObjectInBackground { (object, error) -> Void in
                if object != nil {
                    let like = object!["LikeVlogger"] as? PFObject
                    let image = UIImage(named: "fullLikeTrans.png")
                    sender.setImage(image, for: UIControlState())
                    let pObj = object!
                    let votes = pObj.object(forKey: "NumberOfLikes") as! Int
                    pObj.setObject(votes + 1, forKey: "NumberOfLikes")
                    pObj.saveInBackground()
                    
                    if like == nil {
                        let likeObject = Like(video: object!, user: PFUser.current()!)
                        likeObject.saveInBackground(block: { (succes, error) -> Void in
                            if succes {
                                object!["LikeVlogger"] = likeObject
                                object!.saveInBackground()
                            }
                        })
                    } else {
                        print("testing")
                        let image = UIImage(named: "EmptyLikeTrans.png")
                        sender.setImage(image, for: UIControlState())
                        pObj.setObject(votes - 1, forKey: "numberOfLikes")
                        pObj.saveInBackground()
                        
                        object!.remove(forKey: "LikeVlogger")
                        object!.saveInBackground()
                        like!.deleteInBackground()
                    }
                }
            }
        }
    }
    
    func getLove() {
        let getLquery = PFQuery (className: "Vloggers")
        getLquery.whereKey("ChannelID", equalTo: vChannelID)
        getLquery.getFirstObjectInBackground { (objectLove, error) -> Void in
            if objectLove != nil {
                let love = objectLove!["NumberOfLikes"] as! Int
                self.loveLabel.text = "\(love)"
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
    
    override func viewDidLoad() {
        channelIDDetail.text = vChannelID
        realNameDetail.text = vRealName
        lidSindsDetail.text = vLidSinds
        beschrijvingDetail.text = vBeschrijving
        getLove()
        vloggerVideo.load(withVideoId: videoIDString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            let query = PFQuery (className: "Vloggers")
            query.whereKey("ChannelID", equalTo: vChannelID)
            query.getFirstObjectInBackground { (object, error) -> Void in
                if (object != nil) {
                    print(object as Any)
                    let like = object!["like"] as? PFObject
                    print(like as Any)
                    
                    if like != nil {
                        let image = UIImage(named: "fullLikeTrans.png")
                        self.hartKnop.setImage(image, for: UIControlState())
                        print("Like is not empty")
                    } else {
                        let image = UIImage(named: "EmptyLikeTrans.png")
                        self.hartKnop.setImage(image, for: UIControlState())
                        print("Like is empty")
                    }
            }
        }
    }
}
