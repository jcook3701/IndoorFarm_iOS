//
//  loginWindow.swift
//  seniorProject
//
//  Created by Jared_Cook on 2/1/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation
import UIKit

//-----Firebase Imports -----//
import Firebase
//import FirebaseAuthUI
//import FirebaseGoogleAuthUI
//import FirebaseFacebookAuthUI
//-----Facebook Imports -----//
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
//-----Google Imports -----//
import GoogleSignIn


class mainMenuWindow: gui_init, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    //----------Data Variables----------//
    var dataModel: DataModel!;
    
    //Vars
    var signInButton0: GIDSignInButton!
    var signInButton1: FBSDKLoginButton!
    var signInButton2: UIButton!

    
    override init() {
        super.init();
        //FirebaseApp.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged Into Facebook")
        if let error = error {
            print(error.localizedDescription)
            return
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // User is signed in
                print("Do work")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //----------Screen Dimensions----------//
        self.screenSize = UIScreen.main.bounds;     //Screen Size
        self.screenWidth = screenSize.width;        //Screen Width
        self.screenHeight = screenSize.height;      //Screen Height
        
        //----------Screen Blocks----------//
        self.BlockWidth = screenWidth/NumberOfBlocksWide;          //Block Width: (Screen Width/
        self.BlockHeight = (screenHeight-20)/NumberOfBlocksTall;    //Block Height
        
        //----------Firebase----------//
        //----------Data Variables----------//
        
        //----------Google Sign In----------//
        GIDSignIn.sharedInstance().uiDelegate = self;
        //GIDSignIn.sharedInstance().signIn();      Silent Signin if user has already signed in with googled. 
        self.signInButton0 = GIDSignInButton();
        //self.signInButton0.frame.size = CGSize(width: self.screenWidth*0.6, height: screenHeight/22);
        self.signInButton0.style = GIDSignInButtonStyle.wide;    // => 312x48
        self.signInButton0.center = CGPoint(x: screenWidth/2, y: screenHeight*0.9);
        self.signInButton0.tag = 1;
        view.addSubview(signInButton0);
        let testFrame = self.signInButton0.frame;

        //----------Facebook Sign In----------//
        self.signInButton1 = FBSDKLoginButton();
        self.signInButton1.delegate = self;
        //self.signInButton1.frame.size = CGSize(width: self.screenWidth*0.6, height: screenHeight/13);
        self.signInButton1.frame = testFrame;
        self.signInButton1.titleLabel?.font = self.signInButton1.titleLabel?.font.withSize(screenHeight/45);
        signInButton1.center = CGPoint(x: screenWidth/2, y: screenHeight*0.8);
        view.addSubview(self.signInButton1);
        
        //----------Mail Sign In----------//
        self.signInButton2 = UIButton(frame: testFrame);
        self.signInButton2.addTarget(self.view.inputViewController, action: #selector(buttonAction), for: .touchUpInside);
        self.signInButton2.tag = 0;
        self.signInButton2.setTitle(String("  Sign in with email"), for: .normal);
        self.signInButton2.titleLabel?.font = self.signInButton2.titleLabel?.font.withSize(screenHeight/40);
        self.signInButton2.layer.borderColor = UIColor.black.cgColor;
        self.signInButton2.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0);
        //self.signInButton2.setImage(btnImage , for: UIControlState.normal);#imageLiteral(resourceName: "map")
        self.signInButton2.setImage(#imageLiteral(resourceName: "ic_email.png"), for: UIControlState.normal);
        self.signInButton2.center = CGPoint(x: screenWidth/2, y: screenHeight*0.70);
        view.addSubview(self.signInButton2);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonAction(sender: UIButton!){
        let tag = sender.tag;
        sender.showsTouchWhenHighlighted = true;
        if(tag == 0){//Mail Sign In Button
            //----------Mail Login Screen Init----------//
            let controller = emailLoginWindow();
            controller.view.backgroundColor = UIColor.white;
            controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            controller.title = "Email Login";
            navigationController?.pushViewController(controller, animated: true);
            //present(controller, animated: true, completion: nil);
        }
        if(tag == 1){
            
        }
    }

}
