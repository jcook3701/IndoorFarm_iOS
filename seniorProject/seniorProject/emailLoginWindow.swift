//
//  emailLoginWindow.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/3/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit

class emailLoginWindow: gui_init{
    
    //----------GUI Variables----------//
    var usernameView: UITextField!;
    var passwordView: UITextField!;
    var loginButton: UIButton!;
    var registerButton: UIButton!;
    var forgotPasswordButton: UIButton!;

    //----------Variables----------//

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
        self.loginButton = UIButton();
        self.registerButton = UIButton();
        self.forgotPasswordButton = UIButton();
        
        //----------Variables----------//
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //----------Navigation Bar----------//
        

        /*
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.screenWidth, height: 44))
        let navItem = UINavigationItem(title: "SomeTitle");
        let backItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: "selector");
        navItem.leftBarButtonItem = backItem;
        navBar.setItems([navItem], animated: false);
        navBar.backIndicatorImage = UIImage(named: "backButton")
        navBar.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        navBar.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.view.addSubview(navBar);
        */
 
 
        //----------Username----------//
        self.usernameView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.3 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.usernameView.placeholder = " Username: "
        self.usernameView.layer.borderWidth = 1
        self.view.addSubview(self.usernameView);
        
        //----------Password----------//
        self.passwordView = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.4 ,width:screenWidth*0.9,height:BlockHeight));
        self.passwordView.placeholder = " Password: "
        self.passwordView.layer.borderWidth = 1
        //self.passwordView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.passwordView);
        
        //---------Login Button----------//
        self.loginButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.5 ,width:screenWidth*0.9,height:BlockHeight))
        self.loginButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.loginButton.tag = 0;
        self.loginButton.setTitle(String(" Login"), for: .normal);
        self.loginButton.titleLabel?.font = self.loginButton.titleLabel?.font.withSize(screenHeight/40)
        self.loginButton.layer.borderColor = UIColor.black.cgColor;
        self.loginButton.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0);
        //self.signInButton2.setImage(btnImage , for: UIControlState.normal);#imageLiteral(resourceName: "map")
        view.addSubview(self.loginButton);
        
        //----------Forgot Password----------//
        self.forgotPasswordButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.6 ,width:screenWidth*0.9,height:BlockHeight))
        self.forgotPasswordButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.forgotPasswordButton.tag = 1;
        self.forgotPasswordButton.setTitle(String(" Forgot Password"), for: .normal);
        self.forgotPasswordButton.titleLabel?.font = self.loginButton.titleLabel?.font.withSize(screenHeight/40)
        self.forgotPasswordButton.layer.borderColor = UIColor.black.cgColor;
        self.forgotPasswordButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.forgotPasswordButton.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
        //self.signInButton2.setImage(btnImage , for: UIControlState.normal);#imageLiteral(resourceName: "map")
        view.addSubview(self.forgotPasswordButton);
        
        //----------Register----------//
        self.registerButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.9 ,width:screenWidth*0.9,height:BlockHeight))
        self.registerButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.registerButton.tag = 2;
        self.registerButton.setTitle(String(" Register"), for: .normal);
        self.registerButton.titleLabel?.font = self.loginButton.titleLabel?.font.withSize(screenHeight/40)
        self.registerButton.layer.borderColor = UIColor.black.cgColor;
        self.registerButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        //self.signInButton2.setImage(btnImage , for: UIControlState.normal);#imageLiteral(resourceName: "map")
        view.addSubview(self.registerButton);
        
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left

    }
    
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//Login
            print("Login");
            //----------Mail Login Screen Init----------//
            let controller = controlWindow_0();
            controller.view.backgroundColor = UIColor.white;
            controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            present(controller, animated: true, completion: nil);
        }
        if(tag == 1)
        {
            
        }
        if(tag == 2)
        {
            let controller = emailSetupWindow();
            controller.view.backgroundColor = UIColor.white;
            controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            present(controller, animated: true, completion: nil);
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