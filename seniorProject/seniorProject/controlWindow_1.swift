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
    var growLightRunTimeView: UITextField!;
    var growLightSleepTimeView: UITextField!;
    var waterPumpRunTimeView: UITextField!;
    var waterPumpSleepTimeView: UITextField!;
    var createSettingsButton: UIButton!;
    var deleteSettingsButton: UIButton!;
    var startButtton: UIButton!;
    
    //----------DropDown Variables----------//
    var drop: UIDropDown!
    private var dropCurrentVals: (value:String, position:Int)?
    private var variableValues: Dictionary<String, Double> = [:];   //Holds Value and corresponding value
    public var variableNames = Array<String>();                     //For drop down box    }
    
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
        self.growLightRunTimeView = UITextField();
        self.growLightSleepTimeView = UITextField();
        self.waterPumpRunTimeView = UITextField();
        self.waterPumpSleepTimeView = UITextField();
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
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.1 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Plant Settings "
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;
        
        //----------Drop Down Menu----------//
        self.drop = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.2, width: self.screenWidth*0.9, height: 30));
        self.drop.backgroundColor = UIColor.white;
        self.drop.placeholder = "Plant Select"
        self.drop.options = ["Mexico", "USA", "England", "France", "Germany", "Spain", "Italy", "Canada"]
        self.drop.didSelect{(option, index) in
            //print("String: " + (option) + " number: " + String(index));
            self.dropCurrentVals = (option, index);
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
        
        //----------growLightRunTimeView----------//
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
        self.startButtton.backgroundColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.9, alpha: 1.0);

        
        
        //----------Initialize GUI objects by adding them to the subview----------//
        self.view.addSubview(self.titleView);
        self.view.addSubview(self.planNameView);
        self.view.addSubview(self.plantTraitView);
        self.view.addSubview(self.growLightRunTimeView);
        self.view.addSubview(self.growLightSleepTimeView);
        self.view.addSubview(self.waterPumpRunTimeView);
        self.view.addSubview(self.waterPumpSleepTimeView);
        view.addSubview(self.createSettingsButton);
        view.addSubview(self.deleteSettingsButton);
        view.addSubview(self.startButtton);

        //----------DropDown GUI items need to go last so that you can't see though their dropDown menu----------//
        self.view.addSubview(self.drop);

        
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

