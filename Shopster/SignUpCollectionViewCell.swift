//
//  SignUpCollectionViewCell.swift
//  Shopster
//
//  Created by Nakul on 12/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

protocol PickImage {
    func pickImage()
}

protocol SignUpDone{
    func dismissNow()
}


class SignUpCollectionViewCell: UICollectionViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserPhone: UITextField!
    @IBOutlet weak var SIgnUp: UIButton!
    let storageRef = FIRStorage.storage().reference()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UserImage.layer.cornerRadius = 25
        SIgnUp.isUserInteractionEnabled = true
        UserImage.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        UserImage.addGestureRecognizer(tapGestureRecognizer)

    }
    
    var UserPicksImage: PickImage?
    var SignUp1: SignUpDone?

    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("image tapped")
        UserPicksImage?.pickImage()
        // Your action
    }



    @IBAction func SignUpUser(_ sender: Any) {
        print("reached HEre")
        var email:String!
        var password: String!
        email = UserEmail.text
        password = UserPassword.text
        let image = UserImage.image
        let userProfileRef = storageRef.child("Users/\(UserEmail.text).jpg")
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            print(user as Any)
            print(error as Any )
            
            if(error == nil)
            {
                let uploadTask = userProfileRef.put(UIImageJPEGRepresentation(image!, 0.8)!, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata.downloadURL
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                    changeRequest?.displayName = self.UserName.text
                    changeRequest?.photoURL = downloadURL()
                    print("succesfulSignUP")
                    UserDefaults.standard.set(user?.uid, forKey:"Uid")
                    UserDefaults.standard.set(user?.email, forKey:"Username")
                    UserDefaults.standard.set(password, forKey:"Password")
                    let updateRef = FIRDatabase.database().reference().child("Users")
                    if let user1 = user{
                        updateRef.updateChildValues(["\(user1.uid)" as String! : [ "Cart" : [], "Contact" : "\(self.UserPhone.text!)", "List" : [ ], "M-Wallet" :"0",
                            "Name" : "\(self.UserName.text!)",
                            "Orders" : [[ ]]
                        ]])
                        let addCart = updateRef.child("\(user1.uid)" as String!)
                    }
                    self.SignUp1?.dismissNow()
                    changeRequest?.commitChanges() { (error) in
                        print(error as Any)
                    }
                }
                
            }
        }
        
        
        
    }


}
