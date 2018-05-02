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
    var titleView: UITextField!;
    var lightsView: UITextField!;
    var waterPumpView: UITextField!;
    var drainPumpView: UITextField!;
    var logoutButton: UIButton!;
    var raiseLights: UIButton!;
    var lowerLights: UIButton!;
    var addSettingsDataButton: UIButton!;
    
    var lightSwitch: UISwitch!;
    var waterPumpSwitch: UISwitch!;
    var drainPumpSwitch: UISwitch!;
    
    //----------Firebase Variables----------//
    var conditionRef: DatabaseReference!
    
    
    //----------Keyboard Hider----------//
    
    /*
     @objc func textFieldDidBeginEditing(_ textField: UITextField) {
     if(self.passwordView.isEditing == false){
     //self.passwordView.text = "";
     }
     else{
     self.view.endEditing(true);
     }
     }*/
    
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
        self.lightsView = UITextField();
        self.waterPumpView = UITextField();
        self.drainPumpView = UITextField();
        self.logoutButton = UIButton();
        self.addSettingsDataButton = UIButton();
        self.lightSwitch = UISwitch();
        self.waterPumpSwitch = UISwitch();
        self.drainPumpSwitch = UISwitch();
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //----------Init Firebase Variables----------//
        conditionRef = Database.database().reference();
        
        //----------Settings----------//
        //self.view.backgroundColor = UIColor.green

        
        //----------Title----------//
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.1 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Manual Settings "
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;
        self.view.addSubview(self.titleView);
        
        
        //----------Lights----------//
        self.lightsView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.2 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.lightsView.text = " Lights: "
        self.lightsView.isUserInteractionEnabled = false;
        self.lightsView.layer.borderWidth = 0
        self.view.addSubview(self.lightsView);
        
        self.lightSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.2 ,width:screenWidth*0.4,height:BlockHeight));
        self.lightSwitch.tag = 0;
        self.lightSwitch.setOn(false, animated: true);
        self.lightSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);
        self.view.addSubview(self.lightSwitch);
        
        //----------Water Pump----------//
        self.waterPumpView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.3 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPumpView.text = " Water Pump: "
        self.waterPumpView.isUserInteractionEnabled = false;
        self.waterPumpView.layer.borderWidth = 0
        //self.passwordView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.waterPumpView);
        
        self.waterPumpSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.3 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterPumpSwitch.tag = 1;
        self.waterPumpSwitch.setOn(false, animated: true);
        self.waterPumpSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);
        self.view.addSubview(self.waterPumpSwitch);
        
        
        //----------Drain Pump----------//
        self.drainPumpView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: screenHeight*0.4 ,width:screenWidth*0.4,height:BlockHeight));
        self.drainPumpView.text = " Drain Pump: "
        self.drainPumpView.isUserInteractionEnabled = false;
        self.drainPumpView.layer.borderWidth = 0
        //self.passwordView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.drainPumpView);
        
        self.drainPumpSwitch = UISwitch(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.35) ,y: screenHeight*0.4 ,width:screenWidth*0.4,height:BlockHeight));
        self.drainPumpSwitch.tag = 2;
        self.drainPumpSwitch.setOn(false, animated: true);
        self.drainPumpSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged);
        self.view.addSubview(self.drainPumpSwitch);
        
        //----------Add Settings Data Button----------//
        self.addSettingsDataButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.5 ,width:screenWidth*0.9,height:BlockHeight))
        self.addSettingsDataButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.addSettingsDataButton.tag = 0;
        self.addSettingsDataButton.setTitle(String(" write Database"), for: .normal);
        //self.addSettingsDataButton.titleLabel?.font = self.addSettingsDataButton.titleLabel?.font.withSize(screenHeight/40)
        self.addSettingsDataButton.layer.borderColor = UIColor.black.cgColor;
        self.addSettingsDataButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        //self.signInButton2.setImage(btnImage , for: UIControlState.normal);#imageLiteral(resourceName: "map")
        view.addSubview(self.addSettingsDataButton);
        
        //----------RaiseLights----------//
        self.raiseLights = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.6 ,width:screenWidth*0.9,height:BlockHeight))
        self.raiseLights.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.raiseLights.tag = 1;
        self.raiseLights.setTitle(String("Raise Lights Platform"), for: .normal);
        self.raiseLights.layer.borderColor = UIColor.black.cgColor;
        self.raiseLights.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        view.addSubview(self.raiseLights);
        
        //----------LowerLights----------//
        self.lowerLights = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.7 ,width:screenWidth*0.9,height:BlockHeight))
        self.lowerLights.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.lowerLights.tag = 1;
        self.lowerLights.setTitle(String("Lower Lights Platform"), for: .normal);
        self.lowerLights.layer.borderColor = UIColor.black.cgColor;
        self.lowerLights.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        view.addSubview(self.lowerLights);
        
        //----------LogoutButton----------//
        self.logoutButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.8 ,width:screenWidth*0.9,height:BlockHeight))
        self.logoutButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.logoutButton.tag = 1;
        self.logoutButton.setTitle(String("Logout"), for: .normal);
        self.logoutButton.layer.borderColor = UIColor.black.cgColor;
        self.logoutButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        view.addSubview(self.logoutButton);
        
        
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left
        
    }
    
    @objc func switchAction(sender: UISwitch!){
        let tag = sender.tag;
        if(tag == 0){//Light Switch
            print("Light Value Changed");
            //conditionRef.child("users").child((user.uid)).child("Grow_Light").setValue("1");
            if(sender.isOn == true){
                conditionRef.child("Grow_Light").setValue("1");
            }
            else{
                conditionRef.child("Grow_Light").setValue("0");
            }
        }
        if(tag == 1){//Water Pump Switch
            print("Water Pump Value Changed");
            if(sender.isOn == true){
                conditionRef.child("Water_Pump").setValue("1");
            }
            else{
                conditionRef.child("Water_Pump").setValue("0");
            }
        }
        if(tag == 2){//Drain Pump Switch
            print("Drain Pump Value Changed");
            if(sender.isOn == true){
                conditionRef.child("Drain_Pump").setValue("1");
            }
            else{
                conditionRef.child("Drain_Pump").setValue("0");
            }
        }
    }
    
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//Login
            print("Test Button Pushed");
            guard let user = Auth.auth().currentUser else{
                print("error no user logged in")
                return
            };
            conditionRef.child("users").child((user.uid)).setValue("Hello Firebase")
        }
        if(tag == 1){
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
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = ((keyboardFrame.height) + 40) * (show ? 1 : -1)
        //5
        //UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
        //   self.bottomConstraint.constant += changeInHeight
        //})
    }
    
}

