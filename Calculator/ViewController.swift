//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Deng on 6/26/17.
//  Copyright © 2017 Jonathan Deng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userInMiddleOfTyping = false
    // declare property with getter and setter
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
  
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle! // be careful that sender.currentTitle is not nil
        if userInMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display!.text = updateText(textCurrentlyInDisplay, with: digit)
        } else {
            display!.text = digit
            userInMiddleOfTyping = true
        }
    }
    
    func updateText(_ before: String, with character: String) -> String {
        return before + character
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userInMiddleOfTyping = false
        if let mathSymbol = sender.currentTitle {
            switch mathSymbol {
                case "pi":
                    displayValue = Double.pi
                case "clear":
                    displayValue = 0.0
            default:
                break
            }
        }
    }
  
}

