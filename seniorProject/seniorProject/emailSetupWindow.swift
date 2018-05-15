//
//  emailSetupWindow.swift
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

class emailSetupWindow: gui_init{
    
    //----------Data Variables----------//
    private var dataModel: DataModel!;
    
    //----------Window/Navigation Variables----------//
    var tabBarController_farm_ios: UITabBarController?
    
    //----------GUI Variables----------//
    var usernameView: UITextField!;
    var passwordView0: UITextField!;
    var passwordView1: UITextField!;
    var createAccountButton: UIButton!;

    //----------GUI Variables----------//


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
        self.passwordView0 = UITextField();
        self.passwordView1 = UITextField();
        self.createAccountButton = UIButton();
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        //----------Username----------//
        self.usernameView = UITextField(frame:CGRect(x: self.screenWidth-(self.screenWidth*0.95) ,y: self.screenHeight*0.3 ,width:self.screenWidth*0.9,height:self.BlockHeight));
        self.usernameView.placeholder = " New Email: ";
        self.usernameView.autocorrectionType = .no;
        self.usernameView.autocapitalizationType = .none;
        self.usernameView.spellCheckingType = .no;
        self.usernameView.layer.borderWidth = 1;
        self.usernameView.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.usernameView);
    
        //----------Password0----------//
        self.passwordView0 = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.4 ,width:screenWidth*0.9,height:BlockHeight));
        self.passwordView0.placeholder = " New Password: ";
        self.passwordView0.autocorrectionType = .no;
        self.passwordView0.autocapitalizationType = .none;
        self.passwordView0.spellCheckingType = .no;
        self.passwordView0.layer.borderWidth = 1;
        self.passwordView0.isSecureTextEntry = true;
        self.passwordView0.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.passwordView0);
    
        //----------Password1----------//
        self.passwordView1 = UITextField(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.5 ,width:screenWidth*0.9,height:BlockHeight));
        self.passwordView1.placeholder = " Retype Password: ";
        self.passwordView1.autocorrectionType = .no;
        self.passwordView1.autocapitalizationType = .none;
        self.passwordView1.spellCheckingType = .no;
        self.passwordView1.layer.borderWidth = 1;
        self.passwordView1.isSecureTextEntry = true;
        self.passwordView1.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.touchDown);
        self.view.addSubview(self.passwordView1);
    
        //---------Login Button----------//
        self.createAccountButton = UIButton(frame:CGRect(x: screenWidth-(screenWidth*0.95) ,y: screenHeight*0.6 ,width:screenWidth*0.9,height:BlockHeight))
        self.createAccountButton.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.createAccountButton.tag = 0;
        self.createAccountButton.setTitle(String(" Create Account"), for: .normal);
        self.createAccountButton.titleLabel?.font = self.createAccountButton.titleLabel?.font.withSize(screenHeight/40)
        self.createAccountButton.layer.borderColor = UIColor.black.cgColor;
        self.createAccountButton.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0);
        //self.signInButton2.setImage(btnImage , for: UIControlState.normal);#imageLiteral(resourceName: "map")
        view.addSubview(self.createAccountButton);
    
        //----------Possibly Helpful CMDS----------//
        //self.usernameView.textAlignment = NSTextAlignment.left
}

@objc func buttonAction(sender: UIButton!){
    let tag = sender.tag;
    sender.showsTouchWhenHighlighted = true;
    if(tag == 0){//Login
        //----------Mail Login Screen Init----------//

        guard let email = usernameView.text, !email.isEmpty else {
            print("email is empty");
            return
        }
        
        guard let password0 = passwordView0.text, !password0.isEmpty else {
            print("password0 is empty");
            return
        }
        
        guard let password1 = passwordView1.text, !password1.isEmpty else {
            print("password1 is empty");
            return
        }
        
        if(password0 == password1){
            Auth.auth().createUser(withEmail: email, password: password0) { (user, error) in
                if error == nil{
                    print("Success making account: \(email)" ); 
                }
            }
        }
        print("Login");

        //----------Setup TabBarController----------//
        self.dataModel.readDatabase{ sucess in
            if sucess{
                print("readDatabase: values updated");
                self.dataModel.get_all_plant_settings_firebaseDB{ sucess in
                    if sucess{
                        print("get_all_plant_settings_firebaseDB: values updated");
                        self.tabBarController_farm_ios = Util.setupTabBarController(nav: self.navigationController!, data: self.dataModel);
                        self.navigationController?.pushViewController(self.tabBarController_farm_ios!, animated: true);
                    }
                    else{
                        print("get_all_plant_settings_firebaseDB: values not updated");
                    }
                }
            }
            else{
                print("readDatabase: values not updated");
            }
        }
        print("values should be updated");
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
