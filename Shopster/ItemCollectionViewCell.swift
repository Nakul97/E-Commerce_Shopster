//
//  ItemCollectionViewCell.swift
//  Shopster
//
//  Created by Nakul on 22/04/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase



class ItemCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var Like: UIImageView!
    @IBOutlet weak var Cart: UIImageView!
    @IBOutlet weak var ProductImage: UIImageView!
    var ProductID: String!
    var imgURL:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer1 = UITapGestureRecognizer(target:self, action:#selector(likeButtonPressed))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target:self, action:#selector(AddToCart))
        Like.isUserInteractionEnabled = true
        Cart.isUserInteractionEnabled = true
        Like.addGestureRecognizer(tapGestureRecognizer1)
        Cart.addGestureRecognizer(tapGestureRecognizer2)
        

        // Initialization code
    }
    func GetImage(){
        let storage = FIRStorage.storage()
        let httpsReference = storage.reference(forURL: self.imgURL)
        print(httpsReference)
        httpsReference.data(withMaxSize: 1 * 1024 * 1024)
        { data, error in
              if let error = error {
                print(error)
                // Uh-oh, an error occurred!
            } else {
                let image = UIImage(data: data!)
                self.ProductImage.image = image
            }
        }

    }
    
    
    
    
    func likeButtonPressed()
    {
  
        if(Like.image != #imageLiteral(resourceName: "Liked"))
        {
            var CartItems = [String]()
            let userID = UserDefaults.standard.string(forKey: "Uid")
            let rootRef = FIRDatabase.database().reference().child("Users").child("\(userID!)").child("Likes")
            let CartRef = FIRDatabase.database().reference().child("Users").child("\(userID!)")
            rootRef.observeSingleEvent(of: .value, with: { (snap) in
                
                if var CartItems = (snap.value as? [String]){
                    CartItems.append(self.ProductID)
                    print(CartItems)
                    CartRef.updateChildValues(["Likes": CartItems])
                    
                }
                else{
                    CartRef.updateChildValues(["Likes": [self.ProductID]])
                }
                //rootRef.updateChildValues(["Cart":""])
                
            })

            Like.image = #imageLiteral(resourceName: "Liked")
        }
        else{
            var CartItems = [String]()
            let userID = UserDefaults.standard.string(forKey: "Uid")
            let rootRef = FIRDatabase.database().reference().child("Users").child("\(userID!)").child("Likes")
            let CartRef = FIRDatabase.database().reference().child("Users").child("\(userID!)")
            rootRef.observeSingleEvent(of: .value, with: { (snap) in
                
                if var CartItems = (snap.value as? [String]){
                    if let index = CartItems.index(of: self.ProductID) {
                        CartItems.remove(at: index)
                    }
                    print(CartItems)
                    CartRef.updateChildValues(["Likes": CartItems])
                    
                }
                else{
                    CartRef.updateChildValues(["Likes": [self.ProductID]])
                }
                //rootRef.updateChildValues(["Cart":""])
                
            })

            Like.image = #imageLiteral(resourceName: "Unliked")
        }
        
    }
    func AddToCart()
    {
        if(Cart.image != #imageLiteral(resourceName: "InCart"))
        {
            var CartItems = [String]()
            let userID = UserDefaults.standard.string(forKey: "Uid")
            let rootRef = FIRDatabase.database().reference().child("Users").child("\(userID!)").child("Cart")
            let CartRef = FIRDatabase.database().reference().child("Users").child("\(userID!)")
            rootRef.observeSingleEvent(of: .value, with: { (snap) in
                
                if var CartItems = (snap.value as? [String]){
                    CartItems.append(self.ProductID)
                    print(CartItems)
                    CartRef.updateChildValues(["Cart": CartItems])
                    
                }
                else{
                    CartRef.updateChildValues(["Cart": [self.ProductID]])
                }
                //rootRef.updateChildValues(["Cart":""])
                
            })

            Cart.image = #imageLiteral(resourceName: "InCart")
        }
        else{
            var CartItems = [String]()
            let userID = UserDefaults.standard.string(forKey: "Uid")
            let rootRef = FIRDatabase.database().reference().child("Users").child("\(userID!)").child("Cart")
            let CartRef = FIRDatabase.database().reference().child("Users").child("\(userID!)")
            rootRef.observeSingleEvent(of: .value, with: { (snap) in
                
                if var CartItems = (snap.value as? [String]){
                    if let index = CartItems.index(of: self.ProductID) {
                        CartItems.remove(at: index)
                    }
                    print(CartItems)
                    CartRef.updateChildValues(["Cart": CartItems])
                    
                }
                else{
                    CartRef.updateChildValues(["Cart": [self.ProductID]])
                }
                //rootRef.updateChildValues(["Cart":""])
                
            })
            
     
            Cart.image = #imageLiteral(resourceName: "AddCart")
        }
    }
    


}
