//
//  controlWindow_1.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/6/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit

//-----DropDown Imports -----//
import UIDropDown

//-----Facebook Imports -----//
import Firebase
import FirebaseAuth
import FirebaseDatabase

class controlWindow_1: gui_init{
    
    //----------GUI Variables----------//
    var titleView: UITextField!;
    var planNameView: UITextField!;
    var plantTraitView: UITextField!;
    //var growLightRunTimeView: UITextField!;
    //var growLightSleepTimeView: UITextField!;
    //var waterPumpRunTimeView: UITextField!;
    //var waterPumpSleepTimeView: UITextField!;
    var createSettingsButton: UIButton!;
    var deleteSettingsButton: UIButton!;
    var startButtton: UIButton!;
    
    //----------DropDown Objects & Variables----------//
    //----------plantDropdown----------//
    
    //private var plantDropVariableValues: Dictionary<String, Double> = [:];   //Holds Value and corresponding value
    //public var plantDropVariableNames = Array<String>();                     //For drop down box
    
    var plantDropdown: UIDropDown!
    private var plantDropdownCurrentVals: (value:String, position:Int)?
    
    //----------growLightMaxSleepDropdown----------//
    var growLightMaxSleepDropdown: UIDropDown!;
    private var growLightMaxSleepDropdownCurrentVals: (value:String, position:Int)?;

    //----------growLightMaxTempDropdown----------//
    var growLightMaxTempDropdown: UIDropDown!;
    private var growLightMaxTempDropdownCurrentVals: (value:String, position:Int)?;

    //----------growLightMaxTimerDropdown----------//
    var growLightMaxTimerDropdown: UIDropDown!;
    private var growLightMaxTimerDropdownCurrentVals: (value:String, position:Int)?;

    //----------Firebase Variables----------//
    var conditionRef: DatabaseReference!
    
    //----------Keyboard Hider----------//
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.isEditing == false){
            //textField.text = textField.text;
        }
        else{
            self.view.endEditing(true);
        }
    }
    
    //Draws a line
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.gray.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(line)
    }
    
    override init() {
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        definesPresentationContext = true
        
        
        //----------Screen Dimensions----------//
        self.screenSize = UIScreen.main.bounds;     //Screen Size
        self.screenWidth = screenSize.width;        //Screen Width
        self.screenHeight = screenSize.height;      //Screen Height
        
        //----------Screen Blocks----------//
        self.BlockWidth = screenWidth/NumberOfBlocksWide;          //Block Width: (Screen Width/
        self.BlockHeight = (screenHeight-20)/NumberOfBlocksTall;    //Block Height
        
        //----------Init GUI Variables----------//
        self.titleView = UITextField();
        self.planNameView = UITextField();
        self.plantTraitView = UITextField();
        //self.growLightRunTimeView = UITextField();
        //self.growLightSleepTimeView = UITextField();
        //self.waterPumpRunTimeView = UITextField();
        //self.waterPumpSleepTimeView = UITextField();
        self.createSettingsButton = UIButton();
        self.deleteSettingsButton = UIButton();
        self.startButtton = UIButton();
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //----------Init Firebase Variables----------//
        conditionRef = Database.database().reference();
        
        //----------Settings----------//
        //self.view.backgroundColor = UIColor.red

        //----------Title----------//
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.115 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Plant Settings "
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;
        
        //----------Line----------//
        addLine(fromPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.80), y: self.screenHeight-(self.screenHeight*0.83)), toPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.20), y: self.screenHeight-(self.screenHeight*0.83)));
        
        //----------plantDropdown----------//
        self.plantDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.2, width: self.screenWidth*0.9, height: 30));
        self.plantDropdown.backgroundColor = UIColor.white;
        self.plantDropdown.placeholder = "Plant Select"
        self.plantDropdown.options = ["Tomatos", "Beans", " Broccoli", " Cabbage", "Chives", "Spinach", "Carrots", "Cucumber"]
        self.plantDropdown.didSelect{(option, index) in
            //print("String: " + (option) + " number: " + String(index));
            self.plantDropdownCurrentVals = (option, index);
        }
        //self.drop.options = self.variableNames;

        
        //----------planNameView----------//
        self.planNameView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.3 ,width:self.screenWidth*0.43,height:self.BlockHeight));
        self.planNameView.placeholder = " Plant Name: "
        self.planNameView.layer.borderWidth = 1
        self.planNameView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        
        //----------plantTraitView----------//
        self.plantTraitView = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.48) ,y: screenHeight*0.3 ,width:self.screenWidth*0.43,height:BlockHeight));
        self.plantTraitView.placeholder = " Plant Trait: "
        self.plantTraitView.layer.borderWidth = 1
        self.plantTraitView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        
        //----------growLightMaxTimerDropdown----------//
        self.growLightMaxTimerDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.4, width: self.screenWidth*0.9, height: 30));
        self.growLightMaxTimerDropdown.backgroundColor = UIColor.white;
        self.growLightMaxTimerDropdown.placeholder = "Grow Light: Power On Cycle"
        self.growLightMaxTimerDropdown.options = ["Always On", "30 min", "1 hour", " 1.5 hours", " 2 hours", "2.5 hours", "3 hours", "3.5 hours", "4 hours", "4.5 hours", "5 hours", "5.5 hours", "6 hours", "6.5 hours", "7 hours", "7.5 hours", "8 hours", "8.5 hours", "9 hours", "9.5 hours", "10 hours", "10.5 hours", "11 hours", "11.5 hours", "12 hours"];
        self.growLightMaxTimerDropdown.didSelect{(option, index) in
            //print("String: " + (option) + " number: " + String(index));
            self.growLightMaxTimerDropdownCurrentVals = (option, index);
        }
        //self.drop.options = self.variableNames;
        
        //----------growLightMaxSleepDropdown----------//
        self.growLightMaxSleepDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.5, width: self.screenWidth*0.9, height: 30));
        self.growLightMaxSleepDropdown.backgroundColor = UIColor.white;
        self.growLightMaxSleepDropdown.placeholder = "Grow Light: Power Off Cycle"
        self.growLightMaxSleepDropdown.options = ["Always On", "30 min", "1 hour", " 1.5 hours", " 2 hours", "2.5 hours", "3 hours", "3.5 hours", "4 hours", "4.5 hours", "5 hours", "5.5 hours", "6 hours", "6.5 hours", "7 hours", "7.5 hours", "8 hours", "8.5 hours", "9 hours", "9.5 hours", "10 hours", "10.5 hours", "11 hours", "11.5 hours", "12 hours"];
        self.growLightMaxSleepDropdown.didSelect{(option, index) in
            //print("String: " + (option) + " number: " + String(index));
            self.growLightMaxSleepDropdownCurrentVals = (option, index);
        }
        //self.drop.options = self.variableNames;
        
        //----------growLightMaxTempDropdown----------//
        self.growLightMaxTempDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.6, width: self.screenWidth*0.9, height: 30));
        self.growLightMaxTempDropdown.backgroundColor = UIColor.white;
        self.growLightMaxTempDropdown.placeholder = "Grow Light: Max Temperature"
        self.growLightMaxTempDropdown.options = ["20 degrees", "40 degrees", " 60 degrees", "80 degrees", "100 degrees", "120 degrees", "140 degrees", "160 degrees", "180 degrees", "200 degrees", "220 degrees", "240 degrees", "260 degrees", "280 degrees", "300 degrees"];
        self.growLightMaxTempDropdown.didSelect{(option, index) in
            //print("String: " + (option) + " number: " + String(index));
            self.growLightMaxTempDropdownCurrentVals = (option, index);
        }
        //self.drop.options = self.variableNames;
        
        
        //----------growLightRunTimeView----------//
        
        /*
        self.growLightRunTimeView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.5 ,width:self.screenWidth*0.43,height:self.BlockHeight));
        self.growLightRunTimeView.placeholder = " Grow Light Run Time: "
        self.growLightRunTimeView.layer.borderWidth = 1
        self.growLightRunTimeView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);   
        
        //----------growLightSleepTimeView----------//
        self.growLightSleepTimeView = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.48) ,y: screenHeight*0.5 ,width:self.screenWidth*0.43,height:BlockHeight));
        self.growLightSleepTimeView.placeholder = " Grow Light Sleep Time: "
        self.growLightSleepTimeView.layer.borderWidth = 1
        self.growLightSleepTimeView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        
        //----------waterPumpRunTimeView----------//
        self.waterPumpRunTimeView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.6 ,width:self.screenWidth*0.43,height:self.BlockHeight));
        self.waterPumpRunTimeView.placeholder = " Grow Light Run Time: "
        self.waterPumpRunTimeView.layer.borderWidth = 1
        self.waterPumpRunTimeView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        
        //----------waterPumpSleepTimeView----------//
        self.waterPumpSleepTimeView = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.48) ,y: screenHeight*0.6 ,width:self.screenWidth*0.43,height:BlockHeight));
        self.waterPumpSleepTimeView.placeholder = " Grow Light Sleep Time: "
        self.waterPumpSleepTimeView.layer.borderWidth = 1
        self.waterPumpSleepTimeView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        */
        //----------createSettingsButton----------//
        self.createSettingsButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.7 ,width:self.screenWidth*0.43,height:BlockHeight))
        self.createSettingsButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.createSettingsButton.tag = 0;
        self.createSettingsButton.setTitle(String("Create Settings"), for: .normal);
        self.createSettingsButton.layer.cornerRadius = 5;
        self.createSettingsButton.layer.borderColor = UIColor.black.cgColor;
        //self.createSettingsButton.layer.borderWidth = 1
        self.createSettingsButton.backgroundColor = UIColor(displayP3Red: 0.35, green: 0.6, blue: 0.35, alpha: 1.0);
        
        //----------deleteSettingsButton----------//
        self.deleteSettingsButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.48) ,y:
            screenHeight*0.7 ,width:self.screenWidth*0.43,height:BlockHeight))
        self.deleteSettingsButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.deleteSettingsButton.tag = 1;
        self.deleteSettingsButton.setTitle(String("Delete Settings"), for: .normal);
        self.deleteSettingsButton.layer.cornerRadius = 5;
        self.deleteSettingsButton.layer.borderColor = UIColor.black.cgColor;
        //self.deleteSettingsButton.layer.borderWidth = 1
        self.deleteSettingsButton.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0);

        //----------startButtton----------//
        self.startButtton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.8 ,width:screenWidth*0.9,height:BlockHeight))
        self.startButtton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.startButtton.tag = 2;
        self.startButtton.setTitle(String("Start Growing"), for: .normal);
        self.startButtton.layer.cornerRadius = 5;
        self.startButtton.layer.borderColor = UIColor.black.cgColor;
        //self.startButtton.layer.borderWidth = 1
        self.startButtton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);

        //----------Initialize GUI objects by adding them to the subview----------//
        self.view.addSubview(self.titleView);
        self.view.addSubview(self.planNameView);
        self.view.addSubview(self.plantTraitView);
        view.addSubview(self.createSettingsButton);
        view.addSubview(self.deleteSettingsButton);
        view.addSubview(self.startButtton);

        //----------DropDown GUI items need to go last so that you can't see though their dropDown menu----------//
        self.view.addSubview(self.growLightMaxTempDropdown);
        self.view.addSubview(self.growLightMaxSleepDropdown);
        self.view.addSubview(self.growLightMaxTimerDropdown);
        self.view.addSubview(self.plantDropdown);


        
        //----------growLightMaxTimerDropdown----------//
        
        //self.view.addSubview(self.growLightRunTimeView);
        //self.view.addSubview(self.growLightSleepTimeView);
        //self.view.addSubview(self.waterPumpRunTimeView);
        //self.view.addSubview(self.waterPumpSleepTimeView);

        
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left
        
    }
    
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//Login
            print("Create Button Pushed");
        }
        if(tag == 1){
            print("Delete Button Pushed");

        }
        if(tag == 2){
            print("Start Growing Button Pushed");
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(show: true, notification: notification)
        /*
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         if self.view.frame.origin.y == 0{
         self.view.frame.origin.y -= keyboardSize.height
         }
         }*/
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(show: false, notification: notification)
        /*
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         if self.view.frame.origin.y != 0{
         self.view.frame.origin.y += keyboardSize.height
         }
         }*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        _ = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        _ = ((keyboardFrame.height) + 40) * (show ? 1 : -1)
        //5
        //UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
        //   self.bottomConstraint.constant += changeInHeight
        //})
    }
    
}

