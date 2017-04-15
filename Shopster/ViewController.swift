//
//  ViewController.swift
//  Shopster
//
//  Created by Nakul on 12/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import Firebase
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = UserDefaults.standard.string(forKey: "Username")
        let pass = UserDefaults.standard.string(forKey: "Password")
        DispatchQueue.main.async {
            if(userName == " " && pass == " ")
            {
                self.performSegue(withIdentifier: "Login", sender: self)
            }
            else
            {
                FIRAuth.auth()?.signIn(withEmail: userName!, password: pass!) { (user, error) in
                    print(user as Any)
                    print(error as Any)
                    if(error != nil)
                    {
                        self.performSegue(withIdentifier: "Login", sender: self)
                    }
                    //else display error stop animation
                }
                
            }
            
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

