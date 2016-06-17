//
//  ViewController.swift
//  iPad Calculator
//
//  Created by Gregory D'Alfonso on 6/14/16.
//  Copyright © 2016 shedTech. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
   
/*---------------------------------------- Start of setting button format  ----------------------------*/
 
    @IBOutlet var roundButtonOne: UIButton!
    @IBOutlet var roundButtonTwo: UIButton!
    @IBOutlet var roundButtonThree: UIButton!
    @IBOutlet var roundButtonFour: UIButton!
    @IBOutlet var roundButtonFive: UIButton!
    @IBOutlet var roundButtonSix: UIButton!
    @IBOutlet var roundButtonSeven: UIButton!
    @IBOutlet var roundButtonEight: UIButton!
    @IBOutlet var roundButtonNine: UIButton!
    @IBOutlet var roundButtonTen: UIButton!
    @IBOutlet var roundButtonEleven: UIButton!
    @IBOutlet var roundButtonTwelve: UIButton!
    @IBOutlet var roundButtonThirteen: UIButton!
    @IBOutlet var roundButtonFourteen: UIButton!
    @IBOutlet var roundButtonFifteen: UIButton!
    @IBOutlet var roundButtonSixteen: UIButton!
    @IBOutlet var roundButtonSeventeen: UIButton!
    @IBOutlet var roundButtonEighteen: UIButton!
    @IBOutlet var roundButtonNineteen: UIButton!
    

//this section of code gives the buttons rounded corners -- is there a cleaner way??
    override func viewDidLoad() {
        self.roundButtonOne.layer.cornerRadius = 10
        self.roundButtonTwo.layer.cornerRadius = 10
        self.roundButtonThree.layer.cornerRadius = 10
        self.roundButtonFour.layer.cornerRadius = 10
        self.roundButtonFive.layer.cornerRadius = 10
        self.roundButtonSix.layer.cornerRadius = 10
        self.roundButtonSeven.layer.cornerRadius = 10
        self.roundButtonEight.layer.cornerRadius = 10
        self.roundButtonNine.layer.cornerRadius = 10
        self.roundButtonTen.layer.cornerRadius = 10
        self.roundButtonEleven.layer.cornerRadius = 10
        self.roundButtonTwelve.layer.cornerRadius = 10
        self.roundButtonThirteen.layer.cornerRadius = 10
        self.roundButtonFourteen.layer.cornerRadius = 10
        self.roundButtonFifteen.layer.cornerRadius = 10
        self.roundButtonSixteen.layer.cornerRadius = 10
        self.roundButtonSeventeen.layer.cornerRadius = 10
        self.roundButtonEighteen.layer.cornerRadius = 10
        self.roundButtonNineteen.layer.cornerRadius = 10
    }

/*---------------------------------------------------------------------------------*/
    
    @IBOutlet var accumulatorView: UILabel!
    @IBOutlet var formulaString: UILabel!
    
   
    var accumulator = theAccumulator()
    var isOperandEnabled = true
    var wasOperandUsedBeforeEquals = false
    var isDecimalEnabled = false
    var wasEqualsJustPressed = false
    var percentJustPressed = false
    

    @IBAction func accumulate(sender: AnyObject) {
        
        if percentJustPressed == true {
            clearDisplay()
            accumulator.clearAll()
            percentJustPressed = false
        }
       
        if wasEqualsJustPressed == true {
            clearDisplay()
            accumulator.clearAll()
            wasEqualsJustPressed = false
        }
        
        //clears display if operand was just hit
        if isOperandEnabled == true {
            clearDisplay()
           
            isOperandEnabled = false
        }
       
        //properly accumulates the number depending on size and whether it has a decimal
        if accumulator.one <= 99999999999999 && accumulator.one >= -99999999999999 && isDecimalEnabled == false {
            if accumulator.one >= 0 {
                accumulator.one = (accumulator.one * 10) + Double(sender.tag)
            } else {
                accumulator.one = (accumulator.one * 10) - Double(sender.tag)
            }
        }
        else if isDecimalEnabled == true {
            accumulator.decimalString += String(sender.tag)
        }
        accumulator.currentEquationString += String(sender.tag)
        printToDisplay()
        printToSecondaryDisplay()
       
    }

    //clears everything -- including the formula string
    @IBAction func clearAll() {
        accumulator.clearAll()
        accumulatorView.text! = "0"
        formulaString.text! = ""
        isDecimalEnabled = false
        isOperandEnabled = true
        wasOperandUsedBeforeEquals = false
        wasEqualsJustPressed = false
        accumulator.currentOperand = nil
}

    @IBAction func decimalPressed() {
        //executes statement if current number has no decimal point
        if wasEqualsJustPressed == true {
            clearAll()
        }
        if isOperandEnabled == true && isDecimalEnabled == false{
            accumulatorView.text = "0"
        }
        if isDecimalEnabled == false {
            //prints the decimals on click instead of on calculate
            accumulatorView.text! += "."
            formulaString.text! += "."
            accumulator.currentEquationString += "."
            wasEqualsJustPressed = false
            //toggles the decimal point
            isDecimalEnabled = true
        }
        
        
    }
    
    //toggles the number between positive and negative when the +/- key is pressed
    @IBAction func plusMinus() {
        
        
        if (accumulator.one + Double(accumulator.decimalString)!) != 0 {
            //stores the indecies of the current equation strings negative sign and space -- this is used to toggle the "-" symbol in the string
            let indexOfNegative = accumulator.currentEquationString.rangeOfString("-", options: NSStringCompareOptions.BackwardsSearch)?.startIndex
            let indexOfLastSpace = accumulator.currentEquationString.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch)?.startIndex.advancedBy(1)
            
            //stores the start index of the secondary display string for reference in the if statement below
            let startIndex = accumulator.currentEquationString.startIndex
            
            //makes accumulator negative or positive
            if accumulator.one != 0 {
                accumulator.one *= -1
            } else {
            accumulator.decimalString = String(Double(accumulator.decimalString)! * -1)
            }
            //updates the secondary display to toggle the negative symbol depening on the conditions below
            if indexOfNegative == nil && (accumulator.one + Double(accumulator.decimalString)!) < 0 && indexOfLastSpace == nil {
                accumulator.currentEquationString.insert("-", atIndex: startIndex)
            } else if indexOfLastSpace == nil {
                accumulator.currentEquationString.removeAtIndex(startIndex)
            } else if indexOfLastSpace != nil && (accumulator.one + Double(accumulator.decimalString)!) > 0 && indexOfNegative != nil {
                accumulator.currentEquationString.removeAtIndex(indexOfNegative!)
            } else if indexOfLastSpace != nil && (accumulator.one + Double(accumulator.decimalString)!) < 0 {
                accumulator.currentEquationString.insert("-", atIndex: indexOfLastSpace!)
            }
       
            //updates both of the displays
            printToDisplay()
            printToSecondaryDisplay()
            
            wasEqualsJustPressed = false
        }
    }
    
    //converts current number to percent when % key is pressed
    @IBAction func percent() {
        if wasEqualsJustPressed == false {
        
            if percentJustPressed == false && accumulator.currentEquationString != "" && isOperandEnabled == false{
                
                if accumulator.one >= 0 {
                     accumulator.one = (accumulator.one + Double(accumulator.decimalString)!) / 100
                } else {
                     accumulator.one = (accumulator.one - Double(accumulator.decimalString)!) / 100
                }
               
                accumulator.clearDecimalString()
                wasEqualsJustPressed = false
                accumulator.currentEquationString += "% "
                percentJustPressed = true
                printToDisplay()
                printToSecondaryDisplay()
            }
        }
    }
    
    //stores multiplaction operand when pressed
    @IBAction func multiply() {
       operandToUse("x")
    }
    
    //stores division operand when pressed
    @IBAction func divide() {
      operandToUse("/")
    }
    
    //stores addition operand when pressed
    @IBAction func add() {
       operandToUse("+")
    }
    
    //stores subtraction operand when pressed
    @IBAction func subtract() {
      operandToUse("-")
    }
    
    
    @IBAction func equals() {
        if accumulator.currentEquationString != "" {
            if accumulator.currentOperand == nil {
                formulaString.text! = "\(formatDisplayNumber(accumulator.one + Double(accumulator.decimalString)!)) = \(formatDisplayNumber(accumulator.one + Double(accumulator.decimalString)!))"
                wasEqualsJustPressed = true
            } else {
                if isOperandEnabled == true && wasEqualsJustPressed == false{
                    //stores the index of the last operand
                    let indexOfLastOperand = accumulator.currentEquationString.rangeOfString(accumulator.currentEquationString, options: NSStringCompareOptions.BackwardsSearch)?.endIndex
                    
                    //removes the lingering operand from the formula display
                    accumulator.currentEquationString.removeAtIndex(indexOfLastOperand!.advancedBy(-1))
                    accumulator.currentEquationString.removeAtIndex(indexOfLastOperand!.advancedBy(-2))
                    accumulator.currentEquationString.removeAtIndex(indexOfLastOperand!.advancedBy(-3))
                    
                    wasEqualsJustPressed = true
                    
                    //retrieves the saved value of accumulator.one before operand was used
                    //this is to help accurately calculate when subsequent equals are pressed
                    accumulator.two = accumulator.three
                    accumulator.currentEquationString += " = \(formatDisplayNumber(accumulator.runningTotal))"
                   
                    print(accumulator.one)
                    printToSecondaryDisplay()
                    isOperandEnabled = false
                    equals()
                } else {
        
                if wasEqualsJustPressed == false {
                    //calls equal switch with operand stored in accumulator
                    equalSwitch(accumulator.currentOperand!)
            
                    accumulator.two = accumulator.one + Double(accumulator.decimalString)!
            
                    //updates the current equation string with equals
                    accumulator.currentEquationString += " = \(formatDisplayNumber(accumulator.runningTotal))"
            
                    //clears decimals out
                    accumulator.clearDecimalString()
            
                    //resets operands
                    wasOperandUsedBeforeEquals = false
                    printToSecondaryDisplay()
                    accumulator.currentEquationString = "\(formatDisplayNumber(accumulator.runningTotal))"
            
                    accumulator.one = accumulator.runningTotal
                    
                    //keeps track of equal presses
                    wasEqualsJustPressed = true
                } else {
                    let previousTotal = accumulator.runningTotal
                    accumulator.one = accumulator.two
                    equalSwitch(accumulator.currentOperand!)
                    accumulator.currentEquationString = "\(formatDisplayNumber(previousTotal)) \(accumulator.currentOperand!) \(formatDisplayNumber(accumulator.one)) = \(formatDisplayNumber(accumulator.runningTotal))"
                    printToSecondaryDisplay()
                    }}
                
                //update main display with the running total
                accumulatorView.text! = formatDisplayNumber(accumulator.runningTotal)
                if accumulator.displayNumber == "nan" || accumulator.displayNumber == "+∞"
                {
                    accumulatorView.text! = "error"
                    formulaString.text! = "can't divide by zero"
                    accumulator.clearAll()
                    isOperandEnabled = true
                }
            }
        }
    }
 

    //function sets the operand the was clicked and checks conditions
    func operandToUse(operand: String){
        
        //sets the current operand stored in the accumulator to the operand supplied to this function
        accumulator.currentOperand = operand
        
    //only executes statement if operand hasnt just been used
        if isOperandEnabled == false && wasOperandUsedBeforeEquals == false {
           
            //add the current operand to the question string
            accumulator.currentEquationString += " \(operand) "
            
            //connects the decimal string to the main number for calculation
            addDecimalStringToAccumulator()
            
            //stores .one in .three and reset the accumulator to 0
            accumulator.three = accumulator.one
            accumulator.one = 0
            
            //toggle operand used before equals -- this will cause the next else statement 
            //to execute if operand is pressed again before equals
            wasOperandUsedBeforeEquals = true
            
            //prints the value to the string display
            printToSecondaryDisplay()
            
            //clears the decimal string
            accumulator.clearDecimalString()
            wasEqualsJustPressed = false
            percentJustPressed = false
        } else if isOperandEnabled == false{
            
            //prints the selected operand to the secondary display if an operand is allowed
            if isOperandEnabled == false  {
                accumulator.currentEquationString += " \(operand) "
            }
            
            //calcuates running total using operator supplied to this main function
            equalSwitch(accumulator.lastOperand!)
            
            //displays the running total on the main display
            accumulatorView.text! = formatDisplayNumber(accumulator.runningTotal)
            
            //prints update to the secondary display
            printToSecondaryDisplay()
            
            //stores .one in .three and reset accumulator and decimal string
            accumulator.three = accumulator.one
            accumulator.one = 0
            accumulator.clearDecimalString()
            wasEqualsJustPressed = false
            percentJustPressed = false
        
    }
        /*stores the operand just used in last operand. This is needed to calculate the previous numbers 
          in a calculation string involving more than 2 numbers before equals */
        accumulator.lastOperand = operand
        
        //sets decimal place to not in use
        isDecimalEnabled = false
        
        //allowes operand to be used again
        isOperandEnabled = true
    }
    
    //prints the current display number to display
    func printToDisplay() {
        accumulatorView.text! = accumulator.displayNumber
    }
    
    //prints the current equation to the secondary display
    func printToSecondaryDisplay() {
        if Double(accumulator.currentEquationString) != nil {
        formulaString.text! = formatDisplayNumber(Double(accumulator.currentEquationString)!)
        } else {
            formulaString.text! = accumulator.currentEquationString
        }
    }
    
    //clears the main display
    func clearDisplay() {
        accumulatorView.text! = ""
    }
    
    //clears the seconady view
    func clearSecondaryDisplay() {
        formulaString.text! = ""
    }
    
    //updates the value of the running based on operand provided
    func equalSwitch(operand: String) {
        
        switch operand {
        case "+":
            if accumulator.one >= 0 {
                accumulator.runningTotal += accumulator.one + Double(accumulator.decimalString)!
            } else {
                accumulator.runningTotal += accumulator.one - Double(accumulator.decimalString)!
            }
        case "-":
            if accumulator.one >= 0 {
                accumulator.runningTotal -= accumulator.one + Double(accumulator.decimalString)!
            } else {
                accumulator.runningTotal -= accumulator.one - Double(accumulator.decimalString)!
            }
        case "/":
            if accumulator.one >= 0 {
                accumulator.runningTotal /= accumulator.one + Double(accumulator.decimalString)!
            } else {
                accumulator.runningTotal /= accumulator.one - Double(accumulator.decimalString)!
            }
        case "x":
            if accumulator.one >= 0 {
                accumulator.runningTotal *= accumulator.one + Double(accumulator.decimalString)!
            } else {
                accumulator.runningTotal *= accumulator.one - Double(accumulator.decimalString)!
            }
        default:
            clearAll()
        }
    }
    
    func addDecimalStringToAccumulator() {
        if accumulator.one >= 0 {
            accumulator.runningTotal = accumulator.one + Double(accumulator.decimalString)!
        } else {
            accumulator.runningTotal = accumulator.one - Double(accumulator.decimalString)!
        }
        
    }
    
}