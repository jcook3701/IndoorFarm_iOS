//
//  controlWindow_0.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/1/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit


//-----Facebook Imports -----//
import Firebase
import FirebaseAuth
import FirebaseDatabase

class controlWindow_0: gui_init{
    
    //----------Data Variables----------//
    var dataModel: DataModel!;
    
    //----------GUI Variables----------//
    //----------Row 0----------//
    var titleView: UITextField!;
    //----------Row 1----------//
    var temperature: UITextField!;
    var temp_val: UITextField!;
    //----------Row 2----------//
    var waterLevel: UITextField!;
    var water_val: UITextField!;
    //----------Row 3----------//
    var currentSettingsView: UITextField!;
    //----------Row 4----------//
    var lights: UITextField!;
    var light_val: UITextField!;
    //----------Row 5----------//
    var pump: UITextField!;
    var pump_val: UITextField!;
    //----------Row 6----------//
    var drain: UITextField!;
    var drain_val: UITextField!;
    //----------Row 7----------//
    var purifier: UITextField!;
    var purifier_val: UITextField!;
    //----------Row 8----------//
    var platform_mode: UITextField!;
    var platform_mode_val: UITextField!;

    //----------readDatabase Variables----------//
    var temperatureValue: Double!;
    var waterLevelValue: Bool!;
    var growLightValue: Bool!;
    var waterPumpValue: Bool!;
    var drainPumpValue: Bool!;
    var waterPurifierValue: Bool!;
    var platformModeValue: Bool!;
    
    //----------TimerValue----------//
    var readTimer : Timer!;

    //----------readDatabase Function----------//
    //----------sets readDatabase Variables with values from self.dataModel----------//
    func get_from_dataModel(){
        //----------Init Firebase Variables----------//
        //----------Handle Data Read From FirebaseDB----------//
        self.temperatureValue = (self.dataModel.get_temperature());
        self.waterLevelValue = (self.dataModel.get_water_level()==1 ? true : false);
        self.growLightValue = (self.dataModel.get_grow_light()==1 ? true : false);
        self.waterPumpValue = (self.dataModel.get_water_pump()==1 ? true : false);
        self.drainPumpValue = (self.dataModel.get_drain_pump()==1 ? true : false);
        self.waterPurifierValue = (self.dataModel.get_water_purifier()==1 ? true : false);
        self.platformModeValue = (self.dataModel.get_servo_mode()==1 ? true: false);
    }
    
    func write_to_ui(){
        //----------Set UI Values to have values from FirebaseDB's most recent read----------//
        //----------Row 1----------//
        self.temp_val.text = String(self.temperatureValue);
        //----------Row 2----------//
        if(self.waterLevelValue == true){
            self.water_val.text = "High";
        }
        else{
            self.water_val.text =  "Low";
        }
        //----------Row 4----------//
        if(self.growLightValue == true){
            self.light_val.text = "On";
        }
        else{
            self.light_val.text =  "Off";
        }
        //----------Row 5----------//
        if(self.waterPumpValue == true){
            self.pump_val.text = "On";
        }
        else{
            self.pump_val.text =  "Off";
        }
        //----------Row 6----------//
        if(self.drainPumpValue == true){
            self.drain_val.text = "On";
        }
        else{
            self.drain_val.text =  "Off";
        }
        //----------Row 7----------//
        if(self.waterPurifierValue == true){
            self.purifier_val.text = "On";
        }
        else{
            self.purifier_val.text =  "Off";
        }
        //----------Row 8----------//
        if(self.platformModeValue == true){
            self.platform_mode_val.text = "Mode 1";
        }
        else{
            self.platform_mode_val.text =  "Mode 0";
        }
    }
    
    func update_ui_from_dataModel(){
        self.dataModel.readDatabase{ sucess in
            if sucess{
                self.get_from_dataModel();
                self.write_to_ui();
            }
            else{
                print("values not updated");
            }
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
        definesPresentationContext = true;
        
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
        self.temperature = UITextField();
        self.temp_val = UITextField();
        //----------Row 2----------//
        self.waterLevel = UITextField();
        self.water_val = UITextField();
        //----------Row 3----------//
        self.currentSettingsView = UITextField();
        
        //----------Row 4----------//
        self.lights = UITextField();
        self.light_val = UITextField();
        //----------Row 5----------//
        self.pump = UITextField();
        self.pump_val = UITextField();
        //----------Row 6----------//
        self.drain = UITextField();
        self.drain_val = UITextField();
        //----------Row 7----------//
        self.purifier = UITextField();
        self.purifier_val = UITextField();
        //----------Row 8----------//
        self.platform_mode = UITextField();
        self.platform_mode_val = UITextField();
        
        self.readTimer = Timer();

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        //----------Title----------//
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.115 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Farm Info ";
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;
        
        //----------Line----------//
        addLine(fromPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.80), y: self.screenHeight-(self.screenHeight*0.83)), toPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.20), y: self.screenHeight-(self.screenHeight*0.83)));
        
        //----------Temperature Value----------//
        //----------temperature----------//
        self.temperature = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.18 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.temperature.text = " Temperature: ";
        self.temperature.isUserInteractionEnabled = false;
        self.temperature.layer.borderWidth = 0;
        
        //----------temp_val----------//
        self.temp_val = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.18 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.temp_val.layer.borderWidth = 0;
        self.temp_val.isUserInteractionEnabled = false;
        self.temp_val.textAlignment = .center;
        
        //----------Water Level----------//
        //----------waterLevel----------//
        self.waterLevel = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.26 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterLevel.text = " Water level: ";
        self.waterLevel.isUserInteractionEnabled = false;
        self.waterLevel.layer.borderWidth = 0;

        //----------water_val----------//
        self.water_val = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.26 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.water_val.layer.borderWidth = 0;
        self.water_val.isUserInteractionEnabled = false;
        self.water_val.textAlignment = .center;
        
        
        //----------currentSettingsView----------//
        self.currentSettingsView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.34 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.currentSettingsView.text = " Farm Current Settings ";
        self.currentSettingsView.textAlignment = .center;
        self.currentSettingsView.isUserInteractionEnabled = false;
        self.currentSettingsView.layer.borderWidth = 0;
        
        //----------Line----------//
        addLine(fromPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.80), y: self.screenHeight-(self.screenHeight*0.6)), toPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.20), y: self.screenHeight-(self.screenHeight*0.6)));
        
        //----------Grow Lights----------//
        //----------lights----------//
        self.lights = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.42 ,width:screenWidth*0.4,height:BlockHeight));
        self.lights.text = " Lights: ";
        self.lights.isUserInteractionEnabled = false;
        self.lights.layer.borderWidth = 0;
        
        //----------light_val----------//
        self.light_val = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.42 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.light_val.layer.borderWidth = 0;
        self.light_val.isUserInteractionEnabled = false;
        self.light_val.textAlignment = .center;
        
        //----------Water Pump----------//
        //----------pump----------//
        self.pump = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.5 ,width:screenWidth*0.4,height:BlockHeight));
        self.pump.text = " Water Pump: ";
        self.pump.isUserInteractionEnabled = false;
        self.pump.layer.borderWidth = 0;

        //----------pump_val----------//
        self.pump_val = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.5 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.pump_val.layer.borderWidth = 0;
        self.pump_val.isUserInteractionEnabled = false;
        self.pump_val.textAlignment = .center;
        
        //----------Water Drain----------//
        //----------drain----------//
        self.drain = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.58 ,width:screenWidth*0.4,height:BlockHeight));
        self.drain.text = " Water Drain: ";
        self.drain.isUserInteractionEnabled = false;
        self.drain.layer.borderWidth = 0;
        
        //----------drain_val----------//
        self.drain_val = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.58 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.drain_val.layer.borderWidth = 0;
        self.drain_val.isUserInteractionEnabled = false;
        self.drain_val.textAlignment = .center;
        
        //----------Water Purifier----------//
        //----------purifier----------//
        self.purifier = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.66 ,width:screenWidth*0.4,height:BlockHeight));
        self.purifier.text = " Water Purifier: ";
        self.purifier.isUserInteractionEnabled = false;
        self.purifier.layer.borderWidth = 0;
        
        //----------purifier_val----------//
        self.purifier_val = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.66 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.purifier_val.layer.borderWidth = 0;
        self.purifier_val.isUserInteractionEnabled = false;
        self.purifier_val.textAlignment = .center;
        
        //----------Moving Platform----------//
        //----------platform_mode----------//
        self.platform_mode = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.74 ,width:screenWidth*0.4,height:BlockHeight));
        self.platform_mode.text = " Platform Mode: ";
        self.platform_mode.isUserInteractionEnabled = false;
        self.platform_mode.layer.borderWidth = 0;
        
        //----------platform_mode_val----------//
        self.platform_mode_val = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.74 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.platform_mode_val.layer.borderWidth = 0;
        self.platform_mode_val.isUserInteractionEnabled = false;
        self.platform_mode_val.textAlignment = .center;

        //----------Read Timer----------//
        self.get_from_dataModel();
        self.write_to_ui();
        readTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(readTimerCode), userInfo: nil, repeats: true);
        
        //----------Initialize GUI objects by adding them to the subview----------//
        //----------Row 0----------//
        self.view.addSubview(self.titleView);
        //----------Row 1----------//
        self.view.addSubview(self.temperature);
        self.view.addSubview(self.temp_val);
        //----------Row 2----------//
        self.view.addSubview(self.waterLevel);
        self.view.addSubview(self.water_val);
        //----------Row 3----------//
        self.view.addSubview(self.currentSettingsView);
        //----------Row 4----------//
        self.view.addSubview(self.lights);
        self.view.addSubview(self.light_val);
        //----------Row 5----------//
        self.view.addSubview(self.pump);
        self.view.addSubview(self.pump_val);
        //----------Row 6----------//
        self.view.addSubview(self.drain);
        self.view.addSubview(self.drain_val);
        //----------Row 7----------//
        self.view.addSubview(self.purifier);
        self.view.addSubview(self.purifier_val);
        //----------Row 8----------//
        self.view.addSubview(self.platform_mode);
        self.view.addSubview(self.platform_mode_val);
        
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left
    }
    
    @objc func readTimerCode(sender: Timer!){
        self.update_ui_from_dataModel();
    }
    
    //Dead Code in this Window_0...
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//Login
            /*
            print("Test Button Pushed");
            guard let user = Auth.auth().currentUser else{
                print("error no user logged in")
                return
            };
            conditionRef.child("users").child((user.uid)).setValue("Hello Firebase")
            */
        }
        if(tag == 1){
            /*
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("signing out")
                //----------Pop view controllers----------//
                navigationController?.popToRootViewController(animated: true)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            */
        }
        if(tag == 2){
            //self.ref.child("users").child(user.uid).setValue(["username": username])
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

