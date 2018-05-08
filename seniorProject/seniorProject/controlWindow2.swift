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
    
    
    //----------Row 6----------//
    var resetPlatformSegmentControl: UISegmentedControl!;
    //----------Row 7----------//
    var resetPlatformButton: UIButton!;
    //----------Row 8----------//
    var logoutButton: UIButton!;
    
    //----------Firebase Variables----------//
    var conditionRef: DatabaseReference!
    
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

        
        //----------Row 6----------//
        let resetPlatformitems = ["Mode 0", "Mode 1"];
        self.resetPlatformSegmentControl = UISegmentedControl(items: resetPlatformitems);
        self.resetPlatformSegmentControl.selectedSegmentIndex = 0;
        //----------Row 7----------//
        self.resetPlatformButton = UIButton();
        //----------Row 8----------//
        self.logoutButton = UIButton();
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //----------Init Firebase Variables----------//
        conditionRef = Database.database().reference();
        
        //----------Settings----------//
        //self.view.backgroundColor = UIColor.green
        
        //----------Title----------//
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.115 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Manual Settings "
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;

        //----------12V Lights----------//
        //----------lightsView----------//
        self.lightsView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.18 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.lightsView.text = " 12V Lights: "
        self.lightsView.isUserInteractionEnabled = false;
        self.lightsView.layer.borderWidth = 0
        
        //----------lightSwitch----------//
        self.lightSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.18 ,width:screenWidth*0.4,height:BlockHeight));
        self.lightSwitch.tag = 0;
        self.lightSwitch.setOn(false, animated: true);
        self.lightSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);

        //------------Water Pump-----------//
        //----------waterPumpView----------//
        self.waterPumpView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.26 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPumpView.text = " Water Pump: "
        self.waterPumpView.isUserInteractionEnabled = false;
        self.waterPumpView.layer.borderWidth = 0
        
        //----------waterPumpSwitch----------//
        self.waterPumpSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.26 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPumpSwitch.tag = 1;
        self.waterPumpSwitch.setOn(false, animated: true);
        self.waterPumpSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);
        
        //-----------Drain Pump------------//
        //----------drainPumpView----------//
        self.drainPumpView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.34 ,width:screenWidth*0.4,height:BlockHeight));
        self.drainPumpView.text = " Drain Pump: "
        self.drainPumpView.isUserInteractionEnabled = false;
        self.drainPumpView.layer.borderWidth = 0
        
        //----------drainPumpSwitch----------//
        self.drainPumpSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.34 ,width:screenWidth*0.4,height:BlockHeight));
        self.drainPumpSwitch.tag = 2;
        self.drainPumpSwitch.setOn(false, animated: true);
        self.drainPumpSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);

        //-----------water Purifier------------//
        //----------waterPurifierView----------//
        self.waterPurifierView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.42 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPurifierView.text = " Water Purifier: "
        self.waterPurifierView.isUserInteractionEnabled = false;
        self.waterPurifierView.layer.borderWidth = 0
        
        //----------waterPurifierSwitch----------//
        self.waterPurifierSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.42 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPurifierSwitch.tag = 3;
        self.waterPurifierSwitch.setOn(false, animated: true);
        self.waterPurifierSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);

        //----------------Moving Platform----------------//
        //----------resetPlatformSegmentControl----------//
        self.resetPlatformSegmentControl.frame = CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.6 ,width:screenWidth*0.9,height:BlockHeight);
        self.resetPlatformSegmentControl.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.resetPlatformSegmentControl.tag = 1;
        self.resetPlatformSegmentControl.layer.borderWidth = 1;
        self.resetPlatformSegmentControl.layer.cornerRadius = 5;
        self.resetPlatformSegmentControl.layer.borderColor = UIColor.black.cgColor;
        self.resetPlatformSegmentControl.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        self.resetPlatformSegmentControl.tintColor = UIColor.white;
        
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
                conditionRef.child("Grow_Light").setValue(1);
            }
            else{
                conditionRef.child("Grow_Light").setValue(0);
            }
        }
        if(tag == 1){//Water Pump Switch
            print("Water Pump Value Changed");
            if(sender.isOn == true){
                conditionRef.child("Water_Pump").setValue(1);
            }
            else{
                conditionRef.child("Water_Pump").setValue(0);
            }
        }
        if(tag == 2){//Drain Pump Switch
            print("Drain Pump Value Changed");
            if(sender.isOn == true){
                conditionRef.child("Drain_Pump").setValue(1);
            }
            else{
                conditionRef.child("Drain_Pump").setValue(0);
            }
        }
        if(tag == 3){//Water_Purifier
            print("Water Purifier Value Changed");
            if(sender.isOn == true){
                conditionRef.child("Water_Purifier").setValue(1);
            }
            else{
                conditionRef.child("Water_Purifier").setValue(0);
            }
        }
    }
    
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//resetPlatformButton
            

        }
        if(tag == 1){//LogoutButton
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
        if(tag == 2){
            
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
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = ((keyboardFrame.height) + 40) * (show ? 1 : -1)
        //5
        //UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
        //   self.bottomConstraint.constant += changeInHeight
        //})
    }
    
}

