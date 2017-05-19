//
//  LoginCollectionViewCell.swift
//  Shopster
//
//  Created by Nakul on 12/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase

protocol LoginDone{
    func dismissNow()
}

class LoginCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        LoginButton.isUserInteractionEnabled = true
        // Initialization code
    }
    
    var UserID:String!
    var Login: LoginDone?
    @IBOutlet weak var LoginButton: UIButton!
    @IBAction func Login(_ sender: Any) {
                var email:String!
                var password:String!
                email = Username.text
                password = Password.text
                FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                    print("reached")
                    print(user as Any)
                    print(error as Any)
                    if(error == nil)
                    {
                     self.UserID = user?.uid
                     UserDefaults.standard.set(user?.uid, forKey:"Uid")
                     UserDefaults.standard.set(email, forKey:"Username")
                     UserDefaults.standard.set(password, forKey:"Password")
                        self.Login?.dismissNow()
                    }
                    
                    // ...
                }
        
    }

}
