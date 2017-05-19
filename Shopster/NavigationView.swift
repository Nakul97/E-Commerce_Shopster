//
//  NavigationView.swift
//  Shopster
//
//  Created by Nakul on 17/04/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit

protocol OpenCartView{
    func OpenCart()
}

protocol OpenListView{
    func OpenList()
}


class NavigationView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var CartView: OpenCartView?
    var ListView: OpenListView?
    
    @IBAction func ListView(_ sender: Any) {
        self.ListView?.OpenList()
    }
    
    @IBAction func CartView(_ sender: Any) {
        self.CartView?.OpenCart()
    }
    
    @IBOutlet var NavigationTitleView: UIView!
    override func awakeFromNib() {
        UINib(nibName: "NavigationView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(NavigationTitleView)
        NavigationTitleView.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UINib(nibName: "NavigationView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(NavigationTitleView)
        NavigationTitleView.frame = self.bounds

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
