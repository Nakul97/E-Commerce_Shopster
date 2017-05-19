//
//  CategoriesViewController.swift
//  Shopster
//
//  Created by Ishas Dikshit on 29/04/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit


extension UIView
{
    func snapshotView(scale: CGFloat = 0.0, isOpaque: Bool = true) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, isOpaque, scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func blur(blurRadius: CGFloat) -> UIImage?
    {
        guard let blur = CIFilter(name: "CIGaussianBlur") else { return nil }
        
        let image = self.snapshotView(scale: 1.0, isOpaque: true)
        blur.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        blur.setValue(blurRadius, forKey: kCIInputRadiusKey)
        
        let ciContext  = CIContext(options: nil)
        
        let result = blur.value(forKey: kCIOutputImageKey) as! CIImage!
        
        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: frame.width,
                                  height: frame.height)
        
        let cgImage = ciContext.createCGImage(result!, from: boundingRect)
        
        return UIImage(cgImage: cgImage!)
    }
}




class CategoriesViewController: UIViewController ,iCarouselDelegate,iCarouselDataSource{

    @IBOutlet var CategoriesView: iCarousel!
    var count = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesView.type = .coverFlow
        let Navigation = NavigationView(frame : CGRect(x: 0, y: 0, width: 400, height: 30))
        self.navigationItem.titleView = Navigation

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return count
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let CategoriesView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 60, height: self.view.frame.height - 160))
        CategoriesView.center = self.view.center
        CategoriesView.backgroundColor = UIColor.red
        
        let CategoryImage = UIImageView()
        CategoryImage.image = #imageLiteral(resourceName: "Men")
        CategoryImage.frame = CategoriesView.bounds
        CategoriesView.addSubview(CategoryImage)
        CategoriesView.layer.cornerRadius = 8
        CategoryImage.layer.masksToBounds = true
        CategoryImage.layer.cornerRadius = 8
        
        let view = UIView(frame: CategoriesView.bounds)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        let color = UIColor(red: 153/256, green: 153/256, blue: 153/256, alpha: 1.0)
        gradient.colors = [UIColor.clear.cgColor, color.cgColor]
        gradient.locations = [0.75, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        CategoryImage.addSubview(view)
        CategoryImage.bringSubview(toFront: view)
        
        CategoryImage.contentMode = .scaleAspectFill
        
        return CategoriesView
    }
    
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch (option)
        {
        case .wrap:
            return 1
        case .spacing:
            return 1.2 * value
        default:
            return value
        }
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
