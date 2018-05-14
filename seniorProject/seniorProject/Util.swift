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
        controlWindow0.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0);
        controlWindow1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1);
        controlWindow2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2);
        
        tabBarController.viewControllers = viewControllerList;
        tabBarController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        tabBarController.view.backgroundColor = UIColor.white;
        tabBarController.title = "Indoor Automated Farm";
        tabBarController.navigationItem.hidesBackButton = true;
        tabBarController.selectedIndex = 1;
        
        return tabBarController;
    }
}

