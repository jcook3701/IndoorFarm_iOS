//
//  controlWindow_0.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/1/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit
import DropDown




//-----Facebook Imports -----//
import Firebase
import FirebaseAuth
import FirebaseDatabase

class controlWindow_0: gui_init{
    
    //----------GUI Variables----------//
    var titleView: UITextField!;
    var usernameView: UITextField!;
    var passwordView: UITextField!;
    var logoutButton: UIButton!;
    var addSettingsDataButton: UIButton!;
    var temperature: UITextView!;
    var waterLevel: UITextView!;
    var temp_val: UITextView!;
    var water_val: UITextView!;
    
    
    
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
        self.usernameView = UITextField();
        self.passwordView = UITextField();
        self.logoutButton = UIButton();
        self.addSettingsDataButton = UIButton();
        self.waterLevel = UITextView();
        self.temperature = UITextView();
        self.water_val = UITextView();
        self.temp_val = UITextView();
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //----------Init Firebase Variables----------//
        conditionRef = Database.database().reference();
        
        //----------Settings----------//
      //  self.view.backgroundColor = UIColor.blue
        
        //----------Title----------//
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.1 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Plant Settings "
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;
        self.view.addSubview(self.titleView);
        
        //----------Temperature Value----------//
        self.temperature = UITextView(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.3 ,width:self.screenWidth*0.4,height:self.BlockHeight));
        self.temperature.text = " Temperature: "
        self.temperature.isUserInteractionEnabled = false;
        self.temperature.layer.borderWidth = 0
        self.view.addSubview(self.temperature);

        self.temp_val = UITextView(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.3 ,width:self.screenWidth*0.3,height:self.BlockHeight));
        self.temp_val.layer.borderWidth = 1
        self.view.addSubview(self.temp_val);

        
        //----------Water Level----------//
        self.waterLevel = UITextView(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.4 ,width:screenWidth*0.4,height:BlockHeight));
        self.waterLevel.text = " Water level: "
        self.waterLevel.isUserInteractionEnabled = false;
        self.waterLevel.layer.borderWidth = 0
        //self.passwordView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.waterLevel);

        self.water_val = UITextView(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.4) ,y: self.screenHeight*0.4 ,width:self.screenWidth*0.3,height:self.BlockHeight));
        self.water_val.layer.borderWidth = 1
        self.view.addSubview(self.water_val);
        
      
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left
        
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

