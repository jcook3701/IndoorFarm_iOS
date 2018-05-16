//
//  UINavigationBar-Height.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/4/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit


class Util {
    //-----------------------Initializes tabBarWindow_farm_ios-----------------------//
    class func setupTabBarController(nav: UINavigationController, data: DataModel) -> UITabBarController{
       
        //var plantSettings: plantSettingsContainer!;
        
        
        //----------Collect Values to intialize windows----------//
        //This should be done before this to insure that the collection of values from Firebase has time before the screen's are initilized.
        
        //----------Setup TabBarController----------//
        let tabBarController = UITabBarController();
        
        let controlWindow0 = controlWindow_0();
        let controlWindow1 = controlWindow_1();
        let controlWindow2 = controlWindow_2();
        let viewControllerList = [ controlWindow0, controlWindow1, controlWindow2 ];
        
        //-----Pass FirebaseDB info to all three windows----//
        controlWindow0.dataModel = data;
        controlWindow1.dataModel = data;
        controlWindow2.dataModel = data;
        
        //----------TabBarItems----------//
        let image0 = UIImage(named: "info");
        let image1 = UIImage(named: "auto");
        let image2 = UIImage(named: "manual");
        
        //let tab_image0 = UIImage(cgImage: image0 as! CGImage, scale: 0.5, orientation: .up);
        //let tab_image1 = UIImage(cgImage: image1 as! CGImage, scale: 0.5, orientation: .up);
        //let tab_image2 = UIImage(cgImage: image2 as! CGImage, scale: 0.5, orientation: .up);

        //UIImage(cgImage: CGImage(UIImage(named: "info")), scale: 0.4, orientation: .none)
        let tabBarItem0 = UITabBarItem(title: "Info", image: image0, tag: 0);
        let tabBarItem1 = UITabBarItem(title: "Automation", image: image1, tag: 1);
        let tabBarItem2 = UITabBarItem(title: "Manual", image: image2, tag: 2);
        
        controlWindow0.tabBarItem = tabBarItem0; //UITabBarItem(tabBarSystemItem: .downloads, tag: 0);
        controlWindow1.tabBarItem = tabBarItem1; //UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1);
        controlWindow2.tabBarItem = tabBarItem2; //UITabBarItem(tabBarSystemItem: .favorites, tag: 2);
        
        tabBarController.viewControllers = viewControllerList;
        tabBarController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        tabBarController.view.backgroundColor = UIColor.white;
        tabBarController.title = "Indoor Automated Farm";
        tabBarController.navigationItem.hidesBackButton = true;
        tabBarController.selectedIndex = 1;
        
        return tabBarController;
    }
}

