//
//  controlWindow2.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/6/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit

//-----Facebook Imports -----//
import Firebase
import FirebaseAuth
import FirebaseDatabase

class controlWindow_2: gui_init{
    
    //----------Data Variables----------//
    var dataModel: DataModel!;
    
    //----------GUI Variables----------//
    //----------Row 0----------//
    var titleView: UITextField!;
    //----------Row 1----------//
    var lightsView: UITextField!;
    var lightSwitch: UISwitch!;
    //----------Row 2----------//
    var waterPumpView: UITextField!;
    var waterPumpSwitch: UISwitch!;
    //----------Row 3----------//
    var drainPumpView: UITextField!;
    var drainPumpSwitch: UISwitch!;
    //----------Row 4----------//
    var waterPurifierView: UITextField!;
    var waterPurifierSwitch: UISwitch!;
    //----------Row 5----------//
    var platformTitleView: UITextField!;
    //----------Row 6----------//
    var resetPlatformSegmentControl: UISegmentedControl!;
    //----------Row 7----------//
    var resetPlatformButton: UIButton!;
    //----------Row 8----------//
    var logoutButton: UIButton!;
    
    //----------readDatabase Variables----------//
    var growLightValue: Bool!;
    var waterPumpValue: Bool!;
    var drainPumpValue: Bool!;
    var waterPurifierValue: Bool!;
    var platformModeValue: Int!;
    
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
    
    func update_manaul_settings_page_values(){
        //----------Init Firebase Variables----------//
        //----------Handle Data Read From FirebaseDB----------//
        self.growLightValue = (self.dataModel.get_grow_light()==1 ? true : false);//Bool
        self.waterPumpValue = (self.dataModel.get_water_pump()==1 ? true : false);//Bool
        self.drainPumpValue = (self.dataModel.get_drain_pump()==1 ? true : false);//Bool
        self.waterPurifierValue = (self.dataModel.get_water_purifier()==1 ? true : false);//Bool
        self.platformModeValue = self.dataModel.get_servo_mode();//Int
    }
    
    func write_to_ui(){
        self.lightSwitch.setOn(self.growLightValue, animated: true);//Bool
        self.waterPumpSwitch.setOn(self.waterPumpValue, animated: true);//Bool
        self.drainPumpSwitch.setOn(self.drainPumpValue, animated: true);//Bool
        self.waterPurifierSwitch.setOn(self.waterPurifierValue, animated: true);//Bool
        self.resetPlatformSegmentControl.selectedSegmentIndex = self.platformModeValue;//Int
    }
    
    func update_ui_from_local_dataModel(){
        self.update_manaul_settings_page_values()
        self.write_to_ui();
    }
    
    func update_ui_from_firebaseDB(){
        self.dataModel.readDatabase{ sucess in
            if sucess{
                self.update_manaul_settings_page_values()
                self.write_to_ui();
            }
            else{
                print("values not updated");
            }
        }
    }
    
    override init() {
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Window 2: update from firebaseDB");
        self.update_ui_from_firebaseDB();
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
        //----------Row 0----------//
        self.titleView = UITextField();
        //----------Row 1----------//
        self.lightsView = UITextField();
        self.lightSwitch = UISwitch();
        //----------Row 2----------//
        self.waterPumpView = UITextField();
        self.waterPumpSwitch = UISwitch();
        //----------Row 3----------//
        self.drainPumpView = UITextField();
        self.drainPumpSwitch = UISwitch();
        //----------Row 4----------//
        self.waterPurifierView = UITextField();
        self.waterPurifierSwitch = UISwitch();
        //----------Row 5----------//
        self.platformTitleView = UITextField();
        //----------Row 6----------//
        self.resetPlatformSegmentControl = UISegmentedControl();
        //----------Row 7----------//
        self.resetPlatformButton = UIButton();
        //----------Row 8----------//
        self.logoutButton = UIButton();
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //----------Title----------//
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.115 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Manual Settings "
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;
        
        //----------Line----------//
        addLine(fromPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.80), y: self.screenHeight-(self.screenHeight*0.83)), toPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.20), y: self.screenHeight-(self.screenHeight*0.83)));

        //----------12V Lights----------//
        //----------lightsView----------//
        self.lightsView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.18 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.lightsView.text = " 12V Lights: "
        self.lightsView.isUserInteractionEnabled = false;
        self.lightsView.layer.borderWidth = 0
        
        //----------lightSwitch----------//
        self.lightSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.19 ,width:screenWidth*0.4,height:BlockHeight));
        self.lightSwitch.tag = 0;
        print(self.growLightValue);
        self.lightSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);

        //------------Water Pump-----------//
        //----------waterPumpView----------//
        self.waterPumpView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.26 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPumpView.text = " Water Pump: "
        self.waterPumpView.isUserInteractionEnabled = false;
        self.waterPumpView.layer.borderWidth = 0
        
        //----------waterPumpSwitch----------//
        self.waterPumpSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.27 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPumpSwitch.tag = 1;
        print(self.waterPumpValue);
        self.waterPumpSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);
        
        //-----------Drain Pump------------//
        //----------drainPumpView----------//
        self.drainPumpView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.34 ,width:screenWidth*0.4,height:BlockHeight));
        self.drainPumpView.text = " Drain Pump: "
        self.drainPumpView.isUserInteractionEnabled = false;
        self.drainPumpView.layer.borderWidth = 0
        
        //----------drainPumpSwitch----------//
        self.drainPumpSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.35 ,width:screenWidth*0.4,height:BlockHeight));
        self.drainPumpSwitch.tag = 2;
        print(self.drainPumpValue);
        self.drainPumpSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);

        //-----------water Purifier------------//
        //----------waterPurifierView----------//
        self.waterPurifierView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.42 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPurifierView.text = " Water Purifier: "
        self.waterPurifierView.isUserInteractionEnabled = false;
        self.waterPurifierView.layer.borderWidth = 0
        
        //----------waterPurifierSwitch----------//
        self.waterPurifierSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.43 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPurifierSwitch.tag = 3;
        print(self.waterPurifierValue);
        self.waterPurifierSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);

        //----------------Moving Platform----------------//
        //----------platformTitleView----------//
        self.platformTitleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.52 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.platformTitleView.text = " Platform Settings "
        self.platformTitleView.textAlignment = .center;
        self.platformTitleView.isUserInteractionEnabled = false;
        self.platformTitleView.layer.borderWidth = 0;
        
        //----------Line----------//
        addLine(fromPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.80), y: self.screenHeight-(self.screenHeight*0.43)), toPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.20), y: self.screenHeight-(self.screenHeight*0.43)));
        
        //----------resetPlatformSegmentControl----------//
        let resetPlatformitems = ["Mode 0", "Mode 1"];
        self.resetPlatformSegmentControl = UISegmentedControl(items: resetPlatformitems);
        self.resetPlatformSegmentControl.frame = CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.6 ,width:screenWidth*0.9,height:BlockHeight);
        self.resetPlatformSegmentControl.addTarget(self.view.inputViewController, action: #selector(segmentedControlAction), for: .valueChanged);
        //self.resetPlatformSegmentControl.tag = 1;
        self.resetPlatformSegmentControl.layer.borderWidth = 1;
        self.resetPlatformSegmentControl.layer.cornerRadius = 5;
        self.resetPlatformSegmentControl.layer.borderColor = UIColor.black.cgColor;
        self.resetPlatformSegmentControl.backgroundColor = UIColor.white//UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        self.resetPlatformSegmentControl.tintColor = UIColor.blue;
        
        //----------resetPlatformButton----------//
        self.resetPlatformButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.7 ,width:screenWidth*0.9,height:BlockHeight))
        self.resetPlatformButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.resetPlatformButton.tag = 0;
        self.resetPlatformButton.setTitle(String("Reset Platform"), for: .normal);
        self.resetPlatformButton.layer.cornerRadius = 5;
        self.resetPlatformButton.layer.borderColor = UIColor.black.cgColor;
        self.resetPlatformButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);

        //----------LogoutButton----------//
        self.logoutButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.80 ,width:screenWidth*0.9,height:BlockHeight))
        self.logoutButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.logoutButton.tag = 1;
        self.logoutButton.setTitle(String("Logout"), for: .normal);
        self.logoutButton.layer.cornerRadius = 5;
        self.logoutButton.layer.borderColor = UIColor.black.cgColor;
        self.logoutButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        
        
        //----------Init Firebase Variables----------//
        //----------Handle Data Read From FirebaseDB----------//
        self.update_ui_from_local_dataModel();

        /*
        self.growLightValue = (self.dataModel.get_grow_light()==1 ? true : false);//Bool
        self.waterPumpValue = (self.dataModel.get_water_pump()==1 ? true : false);//Bool
        self.drainPumpValue = (self.dataModel.get_drain_pump()==1 ? true : false);//Bool
        self.waterPurifierValue = (self.dataModel.get_water_purifier()==1 ? true : false);//Bool
        self.platformModeValue = self.dataModel.get_servo_mode();//Int
        
        //Intialize all objects after getting their values//
        self.lightSwitch.setOn(self.growLightValue, animated: true);
        self.waterPumpSwitch.setOn(self.waterPumpValue, animated: true);
        self.drainPumpSwitch.setOn(self.drainPumpValue, animated: true);
        self.waterPurifierSwitch.setOn(self.waterPurifierValue, animated: true);
        self.resetPlatformSegmentControl.selectedSegmentIndex = self.platformModeValue;
        //----------End Init Firebase Variables Code Block----------//
        */
        
        
        //----------Initialize GUI objects by adding them to the subview----------//
        //----------Row 0----------//
        self.view.addSubview(self.titleView);
        //----------Row 1----------//
        self.view.addSubview(self.lightsView);
        self.view.addSubview(self.lightSwitch);
        //----------Row 2----------//
        self.view.addSubview(self.waterPumpView);
        self.view.addSubview(self.waterPumpSwitch);
        //----------Row 3----------//
        self.view.addSubview(self.drainPumpView);
        self.view.addSubview(self.drainPumpSwitch);
        //----------Row 4----------//
        self.view.addSubview(self.waterPurifierView);
        self.view.addSubview(self.waterPurifierSwitch);
        //----------Row 5----------//
        self.view.addSubview(self.platformTitleView);
        //----------Row 6----------//
        self.view.addSubview(self.resetPlatformSegmentControl);
        //----------Row 7----------//
        self.view.addSubview(self.resetPlatformButton);
        //----------Row 8----------//
        self.view.addSubview(self.logoutButton);
        
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left
        
    }
    
    @objc func switchAction(sender: UISwitch!){
        let tag = sender.tag;
        if(tag == 0){//Light Switch
            print("Light Value Changed");
            //conditionRef.child("users").child((user.uid)).child("Grow_Light").setValue("1");
            if(sender.isOn == true){
                self.dataModel.set_grow_light_on();
            }
            else{
                self.dataModel.set_grow_light_off();
            }
        }
        if(tag == 1){//Water Pump Switch
            print("Water Pump Value Changed");
            if(sender.isOn == true){
                self.dataModel.set_water_pump_on()
            }
            else{
                self.dataModel.set_water_pump_off()
            }
        }
        if(tag == 2){//Drain Pump Switch
            print("Drain Pump Value Changed");
            if(sender.isOn == true){
                self.dataModel.set_drain_pump_on();
            }
            else{
                self.dataModel.set_drain_pump_off();
            }
        }
        if(tag == 3){//Water_Purifier
            print("Water Purifier Value Changed");
            if(sender.isOn == true){
                self.dataModel.set_water_purifier_on();
            }
            else{
                self.dataModel.set_water_purifier_off();
            }
        }
    }
    
    @objc func segmentedControlAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            print("Mode 1")
            self.dataModel.set_servo_mode(number: 1);
        default:
            print("Mode 0");
            self.dataModel.set_servo_mode(number: 0);
        }
    }
    
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//reset Platform Button
            self.dataModel.set_servo_reset();
        }
        if(tag == 1){//Logout Button
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("signing out")
                //----------Pop view controllers----------//
                navigationController?.popToRootViewController(animated: true)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
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

