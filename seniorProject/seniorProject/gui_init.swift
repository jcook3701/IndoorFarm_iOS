//
//  gui_init.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/1/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import UIKit
import Foundation

//ONLY USED FOR INITIAL SETUP
class gui_init: UIViewController{
    
    private var buttons = [UIButton]();  //Holds all buttons 0-30
    var tagOfLastButtonPushed = Array<Int>();
    var textBeforeLastButtonPushed :String?;
    
    var numberView: UILabel! = UILabel();
    var currentW: CGFloat = 0.0;        //x-Coordinate
    var currentH: CGFloat = 0.0;        //y-Coordinate
    
    var NumberOfBlocksWide: CGFloat = 4;     //was: WBlocks           //Number of Blocks wide
    var NumberOfBlocksTall: CGFloat = 15;  //was: HBlocks           //Number of Blocks tall
    
    func setCoordinates(myX: CGFloat, myY: CGFloat){
        self.currentW = myX;
        self.currentH = myY;
    }
        //Collects Screen size before creating buttons
    var screenSize: CGRect = CGRect();
    var screenWidth: CGFloat = 0;
    var screenHeight: CGFloat = 0;
    
    var BlockWidth: CGFloat = 0;       //was: BlockW  //Block Width
    var BlockHeight: CGFloat = 0;      //was: BlockH  //Block Height
    
    init() {
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
