//
//  EditProfilePage.swift
//  BeautyApp
//
//  Created by User on 15/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Mark Outlet
    @IBOutlet var profilePictureImageView: UIImageView!
    @IBOutlet var UserNameTextField: UITextField!
    @IBOutlet var BiographyTextField: UITextField!
    @IBOutlet var ChangePasswordTextField: UITextField!
    @IBOutlet var repeatPassword: UITextField!
    
    var currentObject : PFObject!

    //Mark Action
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeProfileButtonTapped(_ sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profilePictureImageView.image = image
        dismiss(animated: true, completion: nil)
        //save picture to parse
        let PFImage = PFFile(data: UIImageJPEGRepresentation(image, 1)!)
        PFUser.current()?.setObject(PFImage!, forKey: "profilePicture")
        PFUser.current()?.saveInBackground {(success: Bool, error: NSError?) -> Void in
            }
        }

    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        let query = PFQuery (className: "_User")
        query.whereKey("email", equalTo: (PFUser.current()?.email)!)
        query.getFirstObjectInBackground { (object, error) -> Void in
        
            if (object != nil) {
                if (self.UserNameTextField.text != "") {
            object?.setValue(self.UserNameTextField.text, forKey: "username")
                }
                if (self.BiographyTextField.text != "") {
            object?.setValue(self.BiographyTextField.text, forKey: "biography")
                }
             if (self.ChangePasswordTextField.text != "") {
                object?.setValue(self.ChangePasswordTextField.text, forKey: "changePassword")
                }
                if (self.repeatPassword.text != "") {
            object?.setValue(self.repeatPassword.text, forKey: "repeatPassword")
                }
                object?.saveInBackground()
                }
            self.allertSaved()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func allertSaved() {
        
                let titleSaved = "Saved"
                let messageSaved = "Your changes has been saved"
    
                let ac = UIAlertController(title: titleSaved, message: messageSaved, preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
    
                ac.addAction(okAction)
                self.present(ac, animated: true, completion: nil)
                }

}

