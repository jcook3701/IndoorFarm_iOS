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

    //-----Firebase Variables-----//
    //-----All Values-----//
    private var firebase_values: NSDictionary?; 
    //-----Always Read-----//
    private var temperature: Double = 0;
    private var water_level: Int = 0;
    //-----Read and Set-----//
    private var grow_light: Int = 0;
    private var water_pump: Int = 0;
    private var drain_pump: Int = 0;
    private var water_purifier: Int = 0;
    private var servo_mode: Int = 0;
    private var servo_reset: Int = 0;
    //-----Automation-----//
    private var grow_light_maxsleep: Int = 0;
    private var grow_light_maxtemp: Int = 0;
    private var grow_light_maxtimer: Int = 0; 
    //-----End Firebase Variables-----//

    
    private var variableValues: Dictionary<String, Double> = [:];   //Holds Value and corresponding value
    public var plantNames = Array<String>();                     //For drop down box    }
    
    private var timer_drop_vals: (value:String, position:Int)?          //Drop down value to be put into minutes

    init(){
        self.conditionRef = Database.database().reference();
    }
    
    //Setter for variableValues and plantNames
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
    
    //-----Getters and Setters for Firebase Variables-----//
    //-----temperature-----//
    func get_temperature() -> Double{
        return self.temperature;
    }
    func set_temperature(number: Double)
    {
        self.temperature = number;
    }
    //-----water_level-----//
    func get_water_level() -> Int{
        return self.water_level;
    }
    func set_water_level(number: Int)
    {
        self.water_level = number;
    }

    //-----grow_light-----//
    func get_grow_light() -> Int{
        return self.grow_light;
    }
    func set_grow_light(number: Int)
    {
        self.grow_light = number;
    }

    //-----water_pump-----//
    func get_water_pump() -> Int{
        return self.water_pump;
    }
    func set_water_pump(number: Int)
    {
        self.water_pump = number;
    }

    //-----drain_pump-----//
    func get_drain_pump() -> Int{
        return self.drain_pump;
    }
    func set_drain_pump(number: Int)
    {
        self.drain_pump = number;
    }
    
    //-----water_purifier-----//
    func get_water_purifier() -> Int{
        return self.water_purifier;
    }
    func set_water_purifier(number: Int)
    {
        self.water_purifier = number;
    }

    //-----servo_mode-----//
    func get_servo_mode() -> Int{
        return self.servo_mode;
    }
    func set_servo_mode(number: Int)
    {
        self.servo_mode = number;
    }

    //-----servo_reset-----//
    func get_servo_reset() -> Int{
        return self.servo_reset;
    }
    func set_servo_reset(number: Int)
    {
        self.servo_reset = number;
    }

    //-----grow_light_maxsleep-----//
    func get_grow_light_maxsleep() -> Int{
        return self.grow_light_maxsleep;
    }
    func set_grow_light_maxsleep(number: Int)
    {
        self.grow_light_maxsleep = number;
    }

    //-----grow_light_maxtemp-----//
    func get_grow_light_maxtemp() -> Int{
        return self.grow_light_maxtemp;
    }
    func set_grow_light_maxtemp(number: Int)
    {
        self.grow_light_maxtemp = number;
    }

    //-----grow_light_maxtimer-----//
    func get_grow_light_maxtimer() -> Int{
        return self.grow_light_maxtimer;
    }
    func set_grow_light_maxtimer(number: Int)
    {
        self.grow_light_maxtimer = number;
    }
    
    //-----Collect Values from Firebase-----//
    func readDatabase() -> NSDictionary {
        
        conditionRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary;
            
            /*
            let grow_light_value = value?["Grow_Light"] as? Int;
            let water_pump_value = value?["Water_Pump"] as? Int;
            let drain_pump_value = value?["Drain_Pump"] as? Int;
            let water_purifier_value = value?["Water_Purifier"] as? Int;
            
            self.grow_light = grow_light_value!;
            self.water_pump = water_pump_value!;
            self.drain_pump = drain_pump_value!;
            self.water_purifier = water_purifier_value!;
            
            print("Grow Light: ", self.grow_light);
            print("Water Pump: ", self.water_pump);
            print("Drain Pump: ", self.drain_pump);
            print("Water Purifier: ", self.water_purifier);
            */
        })
        
        
        
        /*
        conditionRef.child("Grow_Light").observe(.childAdded, with: {snapshot in
            let grow_light_value = snapshot.value as! Int;
            self.grow_light = grow_light_value;
        });
        conditionRef.child("Water_Pump").observe(.childAdded, with: {snapshot in
            let water_pump_value = snapshot.value as! Int;
            self.water_pump = water_pump_value;
        });
        conditionRef.child("Drain_Pump").observe(.childAdded, with: {snapshot in
            let drain_pump_value = snapshot.value as! Int;
            self.drain_pump = drain_pump_value;
        });
        conditionRef.child("Water_Purifier").observe(.childAdded, with: {snapshot in
            let water_purifier_value = snapshot.value as! Int;
            self.water_purifier = water_purifier_value;
        });
        */
    }
}
