//
//  UsersViewController.swift
//  Shopster
//
//  Created by Ishas Dikshit on 30/04/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController {

    @IBOutlet weak var MoneyAddLabel: UITextField!
    @IBOutlet weak var Money: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let Navigation = NavigationView(frame : CGRect(x: 0, y: 0, width: 400, height: 30))
        self.navigationItem.titleView = Navigation
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // Do any additional setup after loading the view.
        view.addGestureRecognizer(tap)
        let userID = UserDefaults.standard.string(forKey: "Uid")
        let rootRef = FIRDatabase.database().reference().child("Users").child("\(userID!)")
        rootRef.observe(.value) {
            (snap: FIRDataSnapshot) in
            let Mwallet = (snap.value as AnyObject)["M-Wallet"]
            self.Money.text = (Mwallet as! String)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateMWallet(_ sender: Any) {
        let userID = UserDefaults.standard.string(forKey: "Uid")
        let rootRef = FIRDatabase.database().reference().child("Users").child("\(userID!)")
        rootRef.observeSingleEvent(of: .value, with: { (snap) in
            let Mwallet = (snap.value as AnyObject)["M-Wallet"]
            self.Money.text = (Mwallet as! String)
            var Money_Int = Int(self.Money.text!)
            Money_Int = Int(self.MoneyAddLabel.text!)! + Money_Int!
            
            rootRef.updateChildValues(["M-Wallet": "\(Money_Int!)"])
            self.MoneyAddLabel.text = "0"
        })
        
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
