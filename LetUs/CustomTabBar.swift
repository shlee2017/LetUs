//
//  CustomTabBar.swift
//  LetUs
//
//  Created by Sangheon Lee on 2/1/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {

    var tabBarIteam = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //needed later when there is images for the tab bar
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        
        let selectedImageHome = UIImage(named: "Home_white")?.withRenderingMode(.alwaysOriginal)
        let deselectedImageHome = UIImage(named: "Home_gray")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = (self.tabBar.items?[0])!
        tabBarIteam.image = deselectedImageHome
        tabBarIteam.selectedImage = selectedImageHome
        
        let selectedImageScan =  UIImage(named: "Scan_white")?.withRenderingMode(.alwaysOriginal)
        let deselectedImageScan = UIImage(named: "Scan_gray")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = (self.tabBar.items?[1])!
        tabBarIteam.image = deselectedImageScan
        tabBarIteam.selectedImage =  selectedImageScan
        
        let selectedImageSetting =  UIImage(named: "Setting_white")?.withRenderingMode(.alwaysOriginal)
        let deselectedImageSetting = UIImage(named: "Setting_gray")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = (self.tabBar.items?[2])!
        tabBarIteam.image = deselectedImageSetting
        tabBarIteam.selectedImage = selectedImageSetting
        
        
        
        /* selected tab background color
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        
        
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , size: tabBarItemSize)*/
        
        // initaial tab bar index
        self.selectedIndex = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
