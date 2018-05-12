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
    
    class func setupMainWindow(nav: UINavigationController, data: DataModel){
        //----------Collect Values to intialize windows----------//
        
        //self.dataModel.readDatabase();
        //----------Setup TabBarController----------//
        let tabBarController = UITabBarController();
        
        let controlWindow0 = controlWindow_0();
        let controlWindow1 = controlWindow_1();
        let controlWindow2 = controlWindow_2();
        let viewControllerList = [ controlWindow0, controlWindow1, controlWindow2 ];
        
        //        self.waterPumpSwitch.setOn(self.waterPumpValue, animated: true);

        print("Grow Light: ", data.get_grow_light());
        print("Water Pump: ", data.get_water_pump());
        print("Drain Pump: ", data.get_drain_pump());
        print("Water Purifier: ", data.get_water_purifier());
        
        print("Grow Light: ", (data.get_grow_light()==1 ? true : false));
        print("Water Pump: ", (data.get_water_pump()==1 ? true : false));
        print("Drain Pump: ", (data.get_drain_pump()==1 ? true : false));
        print("Water Purifier: ", (data.get_water_purifier()==1 ? true : false));
        
        controlWindow2.growLightValue = (data.get_grow_light()==1 ? true : false);
        controlWindow2.waterPumpValue = (data.get_water_pump()==1 ? true : false);
        controlWindow2.drainPumpValue = (data.get_drain_pump()==1 ? true : false);
        controlWindow2.waterPurifierValue = (data.get_water_purifier()==1 ? true : false);
        
        //controlWindow2.lightSwitch!.setOn((data.get_grow_light()==1 ? true : false), animated: true);
        //controlWindow2.waterPumpSwitch!.setOn((data.get_water_pump()==1 ? true : false), animated: true);
        //controlWindow2.drainPumpSwitch!.setOn((data.get_drain_pump()==1 ? true : false), animated: true);
        //controlWindow2.waterPurifierSwitch!.setOn((data.get_drain_pump()==1 ? true : false), animated: true);

        
        controlWindow0.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0);
        controlWindow1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1);
        controlWindow2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2);
        
        tabBarController.viewControllers = viewControllerList;
        tabBarController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        tabBarController.view.backgroundColor = UIColor.white;
        tabBarController.title = "Indoor Automated Farm";
        tabBarController.navigationItem.hidesBackButton = true;
        tabBarController.selectedIndex = 1;
        nav.pushViewController(tabBarController, animated: true);
        //self.nav1?.pushViewController(tabBarController, animated: true)
    }
}

