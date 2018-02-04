//
//  DataService.swift
//  
//
//  Created by Jared_Cook on 2/2/18.
//

import Foundation

import FirebaseDatabase
import Firebase

class DataService {
    let BASE_URL = "https://console.firebase.google.com/project/indoorfarm-92b5b/database/indoorfarm-92b5b/data/";
    static let dataService = DataService()

    private var _BASE_REF = Database.database().reference();
    //private var _BASE_REF = Firebase(url: "\(BASE_URL)");
    //private var _USER_REF = Firebase(url: "\(BASE_URL)/users");
    //private var _JOKE_REF = Firebase(url: "\(BASE_URL)/jokes");
    
    var BASE_REF: DatabaseReference {
        return _BASE_REF;
    }
}
