//
//  internal_model.swift
//  seniorProject
//
//  Created by Jared_Cook on 5/9/18.
//  Copyright © 2018 Jared_Cook. All rights reserved.
//

import Foundation


struct DataModel{
    //Class variables
    
    //-----Always Read-----//
    private var temperature: Double = 0
    private var water_level: Int = 0
    
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
    
    
    /*
    public var result: Double? {
        get{
            return self.total;
        }
    }*/
    
    private var variableValues: Dictionary<String, Double> = [:];   //Holds Value and corresponding value
    public var plantNames = Array<String>();                     //For drop down box    }
    
    private var timer_drop_vals: (value:String, position:Int)?          //Drop down value to be put into minutes

    //Setter for variableValues and plantNames
    mutating func setOperand(variableName: String){
        self.variableValues[variableName] = 0;
        self.plantNames.append(variableName);
    }
    
    mutating func setVariableValuesValue(key: String, value: Double){
        self.variableValues[key] = value;
    }
    
    func getPlantNamesValue(position: Int) -> String?{//plantNames getter for value at position
        return self.plantNames[position];                  //Intended for use with loop
    }
    
    func getVariableValuesValue(key: String) -> Double?{//variablesValue getter for value at position
        return self.variableValues[key];                     //Intended for use with loop
    }
    
    mutating func rmOperand(_ operand: String){//removes the
        self.plantNames = plantNames.filter{$0 != operand };
        self.variableValues.removeValue(forKey: operand);
    }


}
