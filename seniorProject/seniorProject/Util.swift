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
    class func setupMainWindow(nav: UINavigationController){
        //----------Setup TabBarController----------//
        let tabBarController = UITabBarController()
        let controlWindow0 = controlWindow_0()
        controlWindow0.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        let controlWindow1 = controlWindow_1()
        controlWindow1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let controlWindow2 = controlWindow_2()
        controlWindow2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        let viewControllerList = [ controlWindow0, controlWindow1, controlWindow2 ]
        tabBarController.viewControllers = viewControllerList
        tabBarController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        tabBarController.view.backgroundColor = UIColor.white;
        tabBarController.title = "Indoor Farm"
        tabBarController.navigationItem.hidesBackButton = true;
        nav.pushViewController(tabBarController, animated: true)
        //self.nav1?.pushViewController(tabBarController, animated: true)
    }
}
