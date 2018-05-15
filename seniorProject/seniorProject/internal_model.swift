//
//  internal_model.swift
//  seniorProject
//
//  Created by Jared_Cook on 5/9/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseDatabase

class DataModel{
    //Class variables
    var conditionRef: DatabaseReference!

    //-----Firebase values wraped into NSDictionary-----//
    private var firebase_values: NSDictionary?;
    var plant_names: NSDictionary?;
    
    init(){
        self.conditionRef = Database.database().reference();
    }
    
    func get_all_plant_settings_firebaseDB(completion: @escaping (Bool) -> ()){
        
        guard let user = Auth.auth().currentUser else{
            print("error no user logged in")
            return
        };
        conditionRef.child("users").child((user.uid)).observeSingleEvent(of: .value, with: { (snapshot) in
            //-----Collect Values from FirebaseDB-----//
            let value = snapshot.value as? NSDictionary;
            self.plant_names = value;
            //print(self.plant_names!)
            completion(true);
            
        }, withCancel : { error in
            print("with Cancel error");
        })
        
    }
    
    func write_plant_settings_firebaseDB(plant: String, grow_light_maxtimer: Int, grow_light_maxsleep: Int, grow_light_maxtemp: Int, plant_trait: String){
        print("write_plant_settings_firebaseDB: function call");
        guard let user = Auth.auth().currentUser else{
            print("error no user logged in")
            return
        };
        conditionRef.child("users").child((user.uid)).child(plant).setValue(["Grow_Light_Maxtimer": grow_light_maxtimer, "Grow_Light_Maxsleep": grow_light_maxsleep, "Grow_Light_Maxtemp": grow_light_maxtemp, "Plant_Trait": plant_trait]);
    }
    
    func delete_plant_settings_firebaseDB(plant: String){
        print("delete_plant_settings_firebaseDB: function call");
        guard let user = Auth.auth().currentUser else{
            print("error no user logged in")
            return
        };
        conditionRef.child("users").child((user.uid)).child(plant).removeValue();
    }
    
    //-----Collect Values from Firebase-----//
    //-----This must be run before any of the Get commands-----//
    func readDatabase(completion: @escaping (Bool) -> ()) {
        
        conditionRef.observeSingleEvent(of: .value, with: { (snapshot) in
            //-----Collect Values from FirebaseDB-----//
            let value = snapshot.value as? NSDictionary;
            self.firebase_values = value;
            completion(true);
            
        }, withCancel : { error in
            print("with Cancel error");
        })
    }
    
    //-----Getters and Setters for Firebase Variables: Plant Settings-----//
    func get_plant_names_Dictionary() -> NSDictionary! {
        return self.plant_names!;
    }
    
    //-----Inputs are from -----//
    func get_plant_setting_grow_light_maxtimer(plant_type: String) -> Int{
        let grow_light_maxtimer = self.plant_names!.value(forKeyPath: plant_type+".Grow_Light_Maxtimer");
        return grow_light_maxtimer! as! Int;
    }
    
    func get_plant_setting_grow_light_maxsleep(plant_type: String) ->  Int{
        let grow_light_maxsleep = self.plant_names!.value(forKeyPath: plant_type+".Grow_Light_Maxsleep");
        return grow_light_maxsleep! as! Int;
    }
    
    func get_plant_setting_grow_light_maxtemp(plant_type: String) -> Int{
        let grow_light_maxtemp = self.plant_names!.value(forKeyPath: plant_type+".Grow_Light_Maxtemp");
        return grow_light_maxtemp! as! Int;
    }
    
    func get_plant_setting_plant_trait(plant_type: String) -> String{
        let grow_light_maxtimer = self.plant_names!.value(forKeyPath: plant_type+".Plant_Trait");
        return grow_light_maxtimer! as! String;
    }
    
    //-----Getters and Setters for Firebase Variables: Indoor Farm-----//
    //-----Getters collect values from (firebase_values:NSDictionary?). To update getters run readDatabase((completion: @escaping (Bool) -> ()) then run getCMDs-----//
    //-----Setters set values directly on FirebaseDB-----//
    func get_firebase_values_Dictionary() -> NSDictionary! {
        return self.firebase_values!;
    }
    
    //-----temperature-----//
    func get_temperature() -> Double{
        let temperature = self.firebase_values?["Temperature"] as? Double;
        return temperature!;
    }
    
    //-----water_level-----//
    func get_water_level() -> Int{
        let water_level = self.firebase_values?["Water_Level"] as? Int;
        return water_level!;
    }

    //-----grow_light-----//
    func get_grow_light() -> Int{
        let grow_light_value = self.firebase_values?["Grow_Light"] as? Int;
        return grow_light_value!;
    }
    
    func set_grow_light_on(){
        self.conditionRef.child("Grow_Light").setValue(1);
    }
    
    func set_grow_light_off(){
        self.conditionRef.child("Grow_Light").setValue(0);
    }

    //-----water_pump-----//
    func get_water_pump() -> Int{
        let water_pump = self.firebase_values?["Water_Pump"] as? Int;
        return water_pump!;
    }
    
    func set_water_pump_on(){
        self.conditionRef.child("Water_Pump").setValue(1);
    }
    
    func set_water_pump_off(){
        self.conditionRef.child("Water_Pump").setValue(0);
    }

    //-----drain_pump-----//
    func get_drain_pump() -> Int{
        let drain_pump = self.firebase_values?["Drain_Pump"] as? Int;
        return drain_pump!;
    }
    
    func set_drain_pump_on(){
        self.conditionRef.child("Drain_Pump").setValue(1);
    }
    
    func set_drain_pump_off(){
        self.conditionRef.child("Drain_Pump").setValue(0);
    }
    
    //-----water_purifier-----//
    func get_water_purifier() -> Int{
        let water_purifier = self.firebase_values?["Water_Purifier"] as? Int;
        return water_purifier!;
    }
    
    func set_water_purifier_on(){
        self.conditionRef.child("Water_Purifier").setValue(1);
    }
    
    func set_water_purifier_off(){
        self.conditionRef.child("Water_Purifier").setValue(0);
    }

    //-----servo_mode-----//
    func get_servo_mode() -> Int{
        let servo_mode = self.firebase_values?["Servo_Mode"] as? Int;
        return servo_mode!;
    }
    
    //number can be 0 or 1 for corisponding mode 0 or mode 1
    func set_servo_mode(number: Int){
        if(number == 0){
            self.conditionRef.child("Servo_Mode").setValue(0);
        }
        if(number == 1){
            self.conditionRef.child("Servo_Mode").setValue(1);
        }
    }

    //-----servo_reset-----//
    func set_servo_reset(){
        self.conditionRef.child("Servo_Reset").setValue(1);
    }

    //-----grow_light_maxsleep-----//
    func get_grow_light_maxsleep() -> Int{
        let grow_light_maxsleep = self.firebase_values?["Grow_Light_Maxsleep"] as? Int;
        return grow_light_maxsleep!;
    }
    
    func set_grow_light_maxsleep(minutes_cycle: Int){
        self.conditionRef.child("Grow_Light_Maxsleep").setValue(minutes_cycle);
    }

    //-----grow_light_maxtemp-----//
    func get_grow_light_maxtemp() -> Int{
        let grow_light_maxtemp = self.firebase_values?["Grow_Light_Maxtemp"] as? Int;
        return grow_light_maxtemp!;
    }

    //-----grow_light_maxtimer-----//
    func get_grow_light_maxtimer() -> Int{
        let grow_light_maxtimer = self.firebase_values?["Grow_Light_Maxtimer"] as? Int;
        return grow_light_maxtimer!;
    }
    
    func set_grow_light_maxtimer(minutes_cycle: Int){
        self.conditionRef.child("Grow_Light_Maxtimer").setValue(minutes_cycle);
    }
}

class plantSettingsContainer{
    //Class variables
    var conditionRef: DatabaseReference!
    
    //-----Firebase User values wraped into NSDictionary-----//
    
    
    init(){
        self.conditionRef = Database.database().reference();
    }
    

    
    //private var variableValues: Dictionary<String, Double> = [:];   //Holds Value and corresponding value
    //public var plantNames = Array<String>();                     //For drop down box    }
    
    //private var timer_drop_vals: (value:String, position:Int)?          //Drop down value to be put into minutes
    
    
    //Setter for variableValues and plantNames
    
    /*
     func setOperand(variableName: String){
     self.variableValues[variableName] = 0;
     self.plantNames.append(variableName);
     }
     
     func setVariableValuesValue(key: String, value: Double){
     self.variableValues[key] = value;
     }
     
     func getPlantNamesValue(position: Int) -> String?{//plantNames getter for value at position
     return self.plantNames[position];                  //Intended for use with loop
     }
     
     func getVariableValuesValue(key: String) -> Double?{//variablesValue getter for value at position
     return self.variableValues[key];                     //Intended for use with loop
     }
     
     func rmOperand(_ operand: String){//removes the
     self.plantNames = plantNames.filter{$0 != operand };
     self.variableValues.removeValue(forKey: operand);
     }
     */
    
}
