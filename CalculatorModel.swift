//
//  CalculatorModel.swift
//  iPad Calculator
//
//  Created by Gregory D'Alfonso on 6/15/16.
//  Copyright © 2016 shedTech. All rights reserved.
//

import Foundation


//this function will format a double to string value with commas and decimals
func formatDisplayNumber(number: Double) -> String {
    let numberFormatter = NSNumberFormatter()
    if number > -99999999999999 && number < 99999999999999  {
    numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
    } else {
        numberFormatter.numberStyle = NSNumberFormatterStyle.ScientificStyle
    }
    numberFormatter.maximumFractionDigits = 18
    return numberFormatter.stringFromNumber(number)!
}

struct theAccumulator {
    
    var one: Double = 0
    var two: Double = 0
    var three: Double = 0
    
    var displayNumber: String {
        if self.one >= 0 {
            return formatDisplayNumber(self.one + Double(decimalString)!)
        } else {
            return formatDisplayNumber(self.one - Double(decimalString)!)
        }
    }
    
    var lastOperand: String?
    var currentOperand: String?
    
    //current running total
    var runningTotal: Double = 0
    
    //accumulates after decimal is pressed
    var decimalString: String = "0."
    
    //keeps a string of the current equation
    var currentEquationString: String = "" 
    //converts the equation string to a double if needed
    var currentEquationDouble: Double {
        return Double(currentEquationString)!
    }
    
    //clears vaue one
    mutating func clearOne() {
        self.one = 0
    }
    
    //clears value two
    mutating func clearTwo() {
        self.two = 0
    }
    
    //clears value three
    mutating func clearThree() {
        self.three = 0
    }
    
    //clears the running total
    mutating func clearRunningTotal() {
        self.runningTotal = 0
    }
    
    //clears values one and two
    mutating func clearValues() {
        self.one = 0
        self.two = 0
    }
    
    //clears all double values
    mutating func clearAll() {
        self.clearOne()
        self.clearTwo()
        self.clearRunningTotal()
        self.clearDecimalString()
        self.currentEquationString = ""
        self.clearThree()
    }

    
    //clears the decimal string
    mutating func clearDecimalString() {
        self.decimalString = "0."
    }
}



    