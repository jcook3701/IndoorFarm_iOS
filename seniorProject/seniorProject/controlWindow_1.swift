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
    
    //----------Data Variables----------//
    var dataModel: DataModel!;
    //----------GUI Variables----------//
    //----------Row 0----------//
    var titleView: UITextField!;
    //----------Row 1----------//
    var plantDropdown: UIDropDown!;
    //----------Row 2----------//
    var plantNameView: UITextField!;
    var plantTraitView: UITextField!;
    //----------Row 3----------//
    var growLightMaxTimerDropdown: UIDropDown!;
    //----------Row 4----------//
    var growLightMaxSleepDropdown: UIDropDown!;
    //----------Row 5----------//
    var growLightMaxTempDropdown: UIDropDown!;
    //----------Row 6----------//
    var createSettingsButton: UIButton!;
    var deleteSettingsButton: UIButton!;
    //----------Row 7----------//
    var startButtton: UIButton!;
    
    
    //private var plantDropVariableValues: Dictionary<String, Double> = [:];   //Holds Value and corresponding value
    //public var plantDropVariableNames = Array<String>();                     //For drop down box
    
    //----------DropDown Object's Variables----------//
    //----------plantDropdown----------//
    //----------Row 1----------//
    private var plantDropdownCurrentVals: (value:String, position:Int)?;
    
    //----------growLightMaxTimerDropdown----------//
    //----------Row 3----------//
    private var growLightMaxTimerDropdownCurrentVals: (value:String, position:Int)?;
    
    //----------growLightMaxSleepDropdown----------//
    //----------Row 4----------//
    private var growLightMaxSleepDropdownCurrentVals: (value:String, position:Int)?;
    
    //----------growLightMaxTempDropdown----------//
    //----------Row 5----------//
    private var growLightMaxTempDropdownCurrentVals: (value:String, position:Int)?;

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
        let line = CAShapeLayer();
        let linePath = UIBezierPath();
        linePath.move(to: start);
        linePath.addLine(to: end);
        line.path = linePath.cgPath;
        line.strokeColor = UIColor.gray.cgColor;
        line.lineWidth = 1;
        line.lineJoin = kCALineJoinRound;
        self.view.layer.addSublayer(line);
    }
    
    override init() {
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
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
        self.plantDropdown = UIDropDown();
        //----------Row 2----------//
        self.plantNameView = UITextField();
        self.plantTraitView = UITextField();
        //----------Row 3----------//
        self.growLightMaxTimerDropdown = UIDropDown();
        //----------Row 4----------//
        self.growLightMaxSleepDropdown = UIDropDown();
        //----------Row 5----------//
        self.growLightMaxTempDropdown = UIDropDown();
        //----------Row 6----------//
        self.createSettingsButton = UIButton();
        self.deleteSettingsButton = UIButton();
        //----------Row 7----------//
        self.startButtton = UIButton();
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil);

        //----------Title----------//
        self.titleView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y:
            self.screenHeight*0.115 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.titleView.text = " Plant Settings ";
        self.titleView.textAlignment = .center;
        self.titleView.isUserInteractionEnabled = false;
        self.titleView.layer.borderWidth = 0;
        
        //----------Line----------//
        addLine(fromPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.80), y: self.screenHeight-(self.screenHeight*0.83)), toPoint: CGPoint(x: self.screenWidth-(self.screenWidth*0.20), y: self.screenHeight-(self.screenHeight*0.83)));
        
        //----------plantDropdown----------//
        self.plantDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.2, width: self.screenWidth*0.9, height: 30));
        //self.plantDropdown.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .valueChanged);
        //self.plantDropdown.tag = -1;
        self.plantDropdown.backgroundColor = UIColor.white;
        self.plantDropdown.placeholder = "Plant Select";
        self.plantDropdown.options = self.dataModel.plant_names?.allKeys as! [String]; 
        self.plantDropdown.didSelect{(option, index) in
            //print("String: " + (option) + " number: " + String(index));
            print("You just selected \(option) at index: \(index)");

            //-----Sets up plant dropdown placeholder-----//
            self.plantDropdown.placeholder = self.plantDropdown.options[index];

            //-----Sets up both text views-----//
            self.plantNameView.text = option;
            self.plantTraitView.text = self.dataModel.get_plant_setting_plant_trait(plant_type: option);

            //option is selected plant name
            //index is selected dropdown index
            
            //------Collect Dropdown Values-----//
            let grow_light_maxtimer = self.dataModel.get_plant_setting_grow_light_maxtimer(plant_type: option);
            let grow_light_maxsleep = self.dataModel.get_plant_setting_grow_light_maxsleep(plant_type: option);
            let grow_light_maxtemp = self.dataModel.get_plant_setting_grow_light_maxtemp(plant_type: option);
            
            //-----Setup Dropdowns-----//
            self.growLightMaxTimerDropdown.selectedIndex = grow_light_maxtimer/30;
            self.growLightMaxTimerDropdown.placeholder = self.growLightMaxTimerDropdown.options[grow_light_maxtimer/30];
            
            self.growLightMaxSleepDropdown.selectedIndex = grow_light_maxsleep/30;
            self.growLightMaxSleepDropdown.placeholder = self.growLightMaxSleepDropdown.options[grow_light_maxsleep/30];

            self.growLightMaxTempDropdown.selectedIndex = (grow_light_maxtemp/20)-1;
            self.growLightMaxTempDropdown.placeholder = self.growLightMaxTempDropdown.options[(grow_light_maxtemp/20)-1];
        }
        
        //----------plantNameView----------//
        self.plantNameView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.3 ,width:self.screenWidth*0.43,height:self.BlockHeight));
        self.plantNameView.placeholder = " Plant Name: ";
        self.plantNameView.layer.borderWidth = 1;
        self.plantNameView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        
        //----------plantTraitView----------//
        self.plantTraitView = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.48) ,y: screenHeight*0.3 ,width:self.screenWidth*0.43,height:BlockHeight));
        self.plantTraitView.placeholder = " Plant Trait: ";
        self.plantTraitView.layer.borderWidth = 1;
        self.plantTraitView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        
        //----------growLightMaxTimerDropdown----------//
        self.growLightMaxTimerDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.4, width: self.screenWidth*0.9, height: 30));
        self.growLightMaxTimerDropdown.backgroundColor = UIColor.white;
        self.growLightMaxTimerDropdown.placeholder = "Grow Light: Power On Cycle";
        self.growLightMaxTimerDropdown.options = ["Always On", "30 min", "1 hour", "1.5 hours", "2 hours", "2.5 hours", "3 hours", "3.5 hours", "4 hours", "4.5 hours", "5 hours", "5.5 hours", "6 hours", "6.5 hours", "7 hours", "7.5 hours", "8 hours", "8.5 hours", "9 hours", "9.5 hours", "10 hours", "10.5 hours", "11 hours", "11.5 hours", "12 hours"];
        self.growLightMaxTimerDropdown.didSelect{(option, index) in
            self.growLightMaxTimerDropdown.placeholder = self.growLightMaxTimerDropdown.options[index];
        }
        //self.drop.options = self.variableNames;
        
        //----------growLightMaxSleepDropdown----------//
        self.growLightMaxSleepDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.5, width: self.screenWidth*0.9, height: 30));
        self.growLightMaxSleepDropdown.backgroundColor = UIColor.white;
        self.growLightMaxSleepDropdown.placeholder = "Grow Light: Power Off Cycle";
        self.growLightMaxSleepDropdown.options = ["Always On", "30 min", "1 hour", "1.5 hours", "2 hours", "2.5 hours", "3 hours", "3.5 hours", "4 hours", "4.5 hours", "5 hours", "5.5 hours", "6 hours", "6.5 hours", "7 hours", "7.5 hours", "8 hours", "8.5 hours", "9 hours", "9.5 hours", "10 hours", "10.5 hours", "11 hours", "11.5 hours", "12 hours"];
        self.growLightMaxSleepDropdown.didSelect{(option, index) in
            self.growLightMaxSleepDropdown.placeholder = self.growLightMaxSleepDropdown.options[index];
        }
        //self.drop.options = self.variableNames;
        
        //----------growLightMaxTempDropdown----------//
        self.growLightMaxTempDropdown = UIDropDown(frame: CGRect(x: self.screenWidth-(self.screenWidth*0.95), y:
            self.screenHeight*0.6, width: self.screenWidth*0.9, height: 30));
        self.growLightMaxTempDropdown.backgroundColor = UIColor.white;
        self.growLightMaxTempDropdown.placeholder = "Grow Light: Max Temperature";
        self.growLightMaxTempDropdown.options = ["20 Degrees F", "40 Degrees F", "60 Degrees F", "80 Degrees F", "100 Degrees F", "120 Degrees F", "140 Degrees F", "160 Degrees F", "180 Degrees F", "200 Degrees F", "220 Degrees F", "240 Degrees F", "260 Degrees F", "280 Degrees F", "300 Degrees F"];
        self.growLightMaxTempDropdown.didSelect{(option, index) in
            self.growLightMaxTempDropdown.placeholder = self.growLightMaxTempDropdown.options[index];
        }
        //self.drop.options = self.variableNames;
        
        //----------createSettingsButton----------//
        self.createSettingsButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y:
            screenHeight*0.7 ,width:self.screenWidth*0.43,height:BlockHeight));
        self.createSettingsButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.createSettingsButton.tag = 0;
        self.createSettingsButton.setTitle(String("Create Settings"), for: .normal);
        self.createSettingsButton.layer.cornerRadius = 5;
        self.createSettingsButton.layer.borderColor = UIColor.black.cgColor;
        //self.createSettingsButton.layer.borderWidth = 1
        self.createSettingsButton.backgroundColor = UIColor(displayP3Red: 0.35, green: 0.6, blue: 0.35, alpha: 1.0);
        
        //----------deleteSettingsButton----------//
        self.deleteSettingsButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.48) ,y:
            screenHeight*0.7 ,width:self.screenWidth*0.43,height:BlockHeight));
        self.deleteSettingsButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.deleteSettingsButton.tag = 1;
        self.deleteSettingsButton.setTitle(String("Delete Settings"), for: .normal);
        self.deleteSettingsButton.layer.cornerRadius = 5;
        self.deleteSettingsButton.layer.borderColor = UIColor.black.cgColor;
        //self.deleteSettingsButton.layer.borderWidth = 1;
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
        //----------Row 0----------//
        self.view.addSubview(self.titleView);
        //----------Row 2----------//
        self.view.addSubview(self.plantNameView);
        self.view.addSubview(self.plantTraitView);
        //----------Row 6----------//
        view.addSubview(self.createSettingsButton);
        view.addSubview(self.deleteSettingsButton);
        //----------Row 7----------//
        view.addSubview(self.startButtton);

        //----------DropDown GUI items need to go last so that you can't see though their dropDown menu----------//
        //----------Row 5----------//
        self.view.addSubview(self.growLightMaxTempDropdown);
        //----------Row 4----------//
        self.view.addSubview(self.growLightMaxSleepDropdown);
        //----------Row 3----------//
        self.view.addSubview(self.growLightMaxTimerDropdown);
        //----------Row 1----------//
        self.view.addSubview(self.plantDropdown);
        
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left
    }
    
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == -1){//plantDropdown
            print("value Changed")
            print(self.plantDropdown.selectedIndex!);
        }
        if(tag == 0){//Create Button
            print("Create Button Pushed");
            
            //-----Testing to make sure that there are not pre-set-title-values-----//
            let plant_title = self.plantNameView.text!;//String
            let grow_light_maxtimer_title = self.growLightMaxTimerDropdown.placeholder!;
            let grow_light_maxsleep_title = self.growLightMaxSleepDropdown.placeholder!;
            let grow_light_maxtemp_title = self.growLightMaxTempDropdown.placeholder!;
            let plant_trait_title = self.plantTraitView.text!;//String

            let current_grow_light_maxtimer_index = self.growLightMaxTimerDropdown.selectedIndex!;//Int
            let current_grow_light_maxsleep_index = self.growLightMaxSleepDropdown.selectedIndex!;//Int
            let current_grow_light_maxtemp_index = self.growLightMaxTempDropdown.selectedIndex!;//Int
            
            let current_grow_light_maxtimer = self.growLightMaxTimerDropdown.selectedIndex!*30;//Int
            let current_grow_light_maxsleep = self.growLightMaxSleepDropdown.selectedIndex!*30;//Int
            let current_grow_light_maxtemp = ((self.growLightMaxTempDropdown.selectedIndex!+1)*20);//Int
            
            print(plant_title);
            print(current_grow_light_maxtimer_index," ",grow_light_maxtimer_title," ", current_grow_light_maxtimer);
            print(current_grow_light_maxsleep_index," ",grow_light_maxsleep_title," ", current_grow_light_maxsleep);
            print(current_grow_light_maxtemp_index, " ",grow_light_maxtemp_title," ", current_grow_light_maxtemp);
            print(plant_trait_title);
            
            if(plant_title != "Plant Select" &&
                grow_light_maxtimer_title != "Grow Light: Power On Cycle" &&
                grow_light_maxsleep_title != "Grow Light: Power Off Cycle" &&
                grow_light_maxtemp_title != "Grow Light: Max Temperature"){
                
                self.dataModel.write_plant_settings_firebaseDB(plant: plant_title, grow_light_maxtimer: current_grow_light_maxtimer, grow_light_maxsleep: current_grow_light_maxsleep, grow_light_maxtemp: current_grow_light_maxtemp, plant_trait: plant_trait_title);
                
                //-----Updates values from firebase-----//
                self.dataModel.get_all_plant_settings_firebaseDB{ sucess in
                    if sucess{
                        print("get_all_plant_settings_firebaseDB: values updated");
                        //-----Reset plantDropdown options to new firebaseDB values-----//
                        self.plantDropdown.options = self.dataModel.plant_names?.allKeys as! [String];
                    }
                    else{
                        print("get_all_plant_settings_firebaseDB: values not updated");
                    }
                }
            }
        }
        if(tag == 1){//Delete Button
            print("Delete Button Pushed");
            
            //-----Testing to make sure that there are not pre-set-title-values-----//
            let plant_title = self.plantNameView.text!;//String
            let grow_light_maxtimer_title = self.growLightMaxTimerDropdown.placeholder!;
            let grow_light_maxsleep_title = self.growLightMaxSleepDropdown.placeholder!;
            let grow_light_maxtemp_title = self.growLightMaxTempDropdown.placeholder!;
            
            //-----Handles deletion of selected value from firebase-----//
            if(plant_title != "Plant Select" &&
                grow_light_maxtimer_title != "Grow Light: Power On Cycle" &&
                grow_light_maxsleep_title != "Grow Light: Power Off Cycle" &&
                grow_light_maxtemp_title != "Grow Light: Max Temperature"){
                
                //-----Deletes values from firebaseDB-----//
                self.dataModel.delete_plant_settings_firebaseDB(plant: plant_title)
                
                //-----Resets values of all textviews and dropdowns-----//
                //----------Row 1----------//
                self.plantDropdown.placeholder = "Plant Select";
                //----------Row 2----------//
                self.plantNameView.text = "";
                self.plantTraitView.text = "";
                //----------Row 3----------//
                self.growLightMaxTimerDropdown.placeholder = "Grow Light: Power On Cycle";
                //----------Row 4----------//
                self.growLightMaxSleepDropdown.placeholder = "Grow Light: Power Off Cycle";
                //----------Row 5----------//
                self.growLightMaxTempDropdown.placeholder = "Grow Light: Max Temperature";
            
                //-----Updates values from firebase-----//
                self.dataModel.get_all_plant_settings_firebaseDB{ sucess in
                    if sucess{
                        print("get_all_plant_settings_firebaseDB: values updated");
                        //-----Reset plantDropdown options to new firebaseDB values-----//
                        self.plantDropdown.options = self.dataModel.plant_names?.allKeys as! [String];
                    }
                    else{
                        print("get_all_plant_settings_firebaseDB: values not updated");
                    }
                }
            
            }
            
        }
        if(tag == 2){//Start Button
            print("Start Growing Button Pushed");
            //self.dataModel.write_plant_settings_firebaseDB(); 
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

