//
//  emailLoginWindow.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/3/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit

//-----Firebase Imports -----//
import Firebase
//import FirebaseAuthUI

class emailLoginWindow: gui_init{

    //----------Data Variables----------//
    var dataModel: DataModel!;
    
    //----------Window/Navigation Variables----------//
    var tabBarController_farm_ios: UITabBarController?
    
    //----------GUI Variables----------//
    var usernameView: UITextField!;
    var passwordView: UITextField!;
    var loginButton: UIButton!;
    var registerButton: UIButton!;
    var forgotPasswordButton: UIButton!;

    //----------Variables----------//
    var navBar: UINavigationBar!;

    //----------Keyboard Hider----------//
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.isEditing == false){
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
  
    /*
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }*/

    
    override func viewDidLoad() {
        super.viewDidLoad();

        //----------Screen Dimensions----------//
        self.screenSize = UIScreen.main.bounds;     //Screen Size
        self.screenWidth = screenSize.width;        //Screen Width
        self.screenHeight = screenSize.height;      //Screen Height
        
        //----------Screen Blocks----------//
        self.BlockWidth = screenWidth/NumberOfBlocksWide;          //Block Width: (Screen Width/
        self.BlockHeight = (screenHeight-20)/NumberOfBlocksTall;    //Block Height
        
        //----------Data Variables----------//
        self.dataModel = DataModel();
        
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
    
        //---------- status bar background color----------//
        //let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        //let statusBarColor = self.navBar.barTintColor
        //statusBarView.backgroundColor = UIColor.clear
        //view.addSubview(statusBarView)
        
        //----------Username----------//
        self.usernameView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.3 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.usernameView.placeholder = " Username: "
        self.usernameView.autocorrectionType = .no;
        self.usernameView.autocapitalizationType = .none;
        self.usernameView.spellCheckingType = .no;
        self.usernameView.layer.borderWidth = 1
        self.usernameView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.usernameView);
        
        //----------Password----------//
        self.passwordView = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.4 ,width:screenWidth*0.9,height:BlockHeight));
        self.passwordView.placeholder = " Password: "
        self.passwordView.autocorrectionType = .no;
        self.passwordView.autocapitalizationType = .none;
        self.passwordView.spellCheckingType = .no;
        self.passwordView.layer.borderWidth = 1
        self.passwordView.isSecureTextEntry = true;
        self.passwordView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
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
    
    //----------Button Actions----------//
    //----------"Login", "Forgot Password", "Register"----------//
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//Login Button
            
            guard let email = usernameView.text, !email.isEmpty else {
                print("email is empty");
                return
            }
            
            guard let password = passwordView.text, !password.isEmpty else {
                print("password0 is empty");
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil{
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")

                    //----------Setup TabBarController----------//
                    self.dataModel.readDatabase{ sucess in
                        if sucess{
                            print("values updated");
                            self.tabBarController_farm_ios = Util.setupTabBarController(nav: self.navigationController!, data: self.dataModel);
                            self.navigationController?.pushViewController(self.tabBarController_farm_ios!, animated: true);
                        }
                        else{
                            print("values not updated");
                        }
                    }
                    print("Values should be updated");
                }
                else{
                    print("error")
                }
            }
        }
        if(tag == 1)
        {//Forgot Password Button
            

        }
        if(tag == 2)
        {//Register Button
            let controller = emailSetupWindow();
            controller.view.backgroundColor = UIColor.white;
            controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            controller.title = "Email Setup"
            navigationController?.pushViewController(controller, animated: true)
            //present(controller, animated: true, completion: nil);
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
