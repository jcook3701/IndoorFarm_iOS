//
//  UINavigationBar-Height.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/4/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationBar : UINavigationBar {
    
    private let hiddenStatusBar: Bool
    
    // MARK: Init
    init(hiddenStatusBar: Bool = false) {
        self.hiddenStatusBar = hiddenStatusBar
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 11.0, *) {
            for subview in self.subviews {
                let stringFromClass = NSStringFromClass(subview.classForCoder)
                if stringFromClass.contains("BarBackground") {
                    subview.frame = self.bounds
                } else if stringFromClass.contains("BarContentView") {
                    let statusBarHeight = self.hiddenStatusBar ? 0 : UIApplication.shared.statusBarFrame.height
                    subview.frame.origin.y = statusBarHeight
                    subview.frame.size.height = self.bounds.height - statusBarHeight
                }
            }
        }
    }
}
