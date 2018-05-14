//
//  AppDelegate.swift
//  seniorProject
//
//  Created by Jared_Cook on 1/31/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

//-----Built-in Imports -----//
import UIKit
//-----Facebook Imports -----//
import Firebase
import FirebaseDatabase
//import FirebaseAuthUI
//import FirebaseGoogleAuthUI
//import FirebaseFacebookAuthUI
//-----Google Imports -----//
import GoogleSignIn

//import FacebookLogin
//import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    //----------Data Variables----------//
    private var dataModel: DataModel!;
    
    
    //----------Window/Navigation Variables----------//
    var window: UIWindow?
    var navController_farm_ios: UINavigationController?
    var tabBarController_farm_ios: UITabBarController?
    //var ref: DatabaseReference!
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        //guard (GIDSignIn.sharedInstance().uiDelegate as? controlWindow_0 else {return};
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("Sign In!");

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        //let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        print(credential)
        //Auth.auth().signInAndRetrieveData(with: credential, completion: AuthResultCallback = nil);


        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
         
            // User is signed in
            print("User is signed in")
            //----------Setup TabBarController----------//
            self.dataModel.readDatabase{ sucess in
                if sucess{
                    print("values updated");
                    self.tabBarController_farm_ios = Util.setupTabBarController(nav: self.navController_farm_ios!, data: self.dataModel);
                    self.navController_farm_ios?.pushViewController(self.tabBarController_farm_ios!, animated: true);
                }
                else{
                    print("values not updated");
                }
            }
           //self.tabBarController_farm_ios = Util.setupTabBarController(nav: self.navController_farm_ios!, data: self.dataModel);
           //self.navController_farm_ios!.pushViewController(self.tabBarController_farm_ios!, animated: true);

        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("Sign out!");
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //--------Firebase--------//
        // Use Firebase library to configure APIs'
        FirebaseApp.configure()
        
        //--------Google-login--------//
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID;
        GIDSignIn.sharedInstance().delegate = self;
 
        //ref = Database.database().reference();
        //--------Firebase--------//
        //myLoginWindow
        
        //--------Screen Launch--------//
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window?.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0);
        self.navController_farm_ios = UINavigationController();
        let mainView = mainMenuWindow(); //ViewController = Name of your controller
        self.navController_farm_ios?.pushViewController(mainView, animated: true);
        self.window!.rootViewController = self.navController_farm_ios;
        self.window?.makeKeyAndVisible();
        
       
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

