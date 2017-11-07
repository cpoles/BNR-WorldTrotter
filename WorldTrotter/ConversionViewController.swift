//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Carlos Poles on 7/11/17.
//  Copyright © 2017 Carlos Poles. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController {
    
    // MARK: Outlets
    
    // create outlet to the Celsius label and to the Text Field
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        // property observer to observe for changes so that
        // whenever the value of this property changes, the observer is triggered
        didSet {
            updateCelsiusLabel() // call the updateCelsiusLabel() method
                                // whenever the property is set
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    // MARK: Class Methods
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = "\(celsiusValue)"
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    
    
    // MARK: Action Methods
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        // check if text field contains any text and check as it changes
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
}

