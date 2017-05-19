//
//  ViewController.swift
//  Shopster
//
//  Created by Nakul on 12/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import Firebase
import UIKit

class ViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,OpenListView,OpenCartView{

    func OpenCart() {
       let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "CartsView")
        self.present(VC1, animated: true, completion: nil)
    }
    func OpenList() {
        print("Add")
    }
    
    @IBOutlet weak var ItemsCollectioniew: UICollectionView!
    
    var Images = [UIImage]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(Products.count == 0){
            return 0
        }
        else {
            return Products.count - 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Items", for: indexPath) as! ItemCollectionViewCell
       cell.ProductPrice.text =  ((((self.Products[indexPath.row + 1]) as AnyObject)["Price"]) as! String)
       
        cell.ProductName.text =  ((((self.Products[indexPath.row + 1]) as AnyObject)["Name"]) as! String)
        print(Images.count)
        cell.imgURL = ((((self.Products[indexPath.row + 1]) as AnyObject)["IMGURL"]) as! String)
        cell.GetImage()
        cell.ProductID = "\(indexPath.row + 1)"
        return cell
    }
    
    var Products = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ItemsCollectioniew.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Items")
        let userName = UserDefaults.standard.string(forKey: "Username")
        let pass = UserDefaults.standard.string(forKey: "Password")
        self.automaticallyAdjustsScrollViewInsets = false
        DispatchQueue.main.async {
            if(userName == " " && pass == " ")
            {
                self.performSegue(withIdentifier: "Login", sender: self)
            }
            else
            {
                FIRAuth.auth()?.signIn(withEmail: userName!, password: pass!) { (user, error) in
                    print(error as Any)
                    if(error != nil)
                    {
                        self.performSegue(withIdentifier: "Login", sender: self)
                    }
                    //else display error stop animation
                }
                
            }
            
        }
        let rootRef = FIRDatabase.database().reference().child("Products")
        let storage = FIRStorage.storage()
        let Navigation = NavigationView(frame : CGRect(x: 0, y: 0, width: 400, height: 30))
        self.navigationItem.titleView = Navigation
        Navigation.CartView = self
        rootRef.observe(.value) {
            (snap: FIRDataSnapshot) in
            let sample = ((snap.value as! [AnyObject]))
            self.Products = sample
            self.ItemsCollectioniew.reloadData()
        }        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wid = self.view.frame.width/2 - 7.5
        return CGSize(width: wid, height: 240)
    }

    
}

