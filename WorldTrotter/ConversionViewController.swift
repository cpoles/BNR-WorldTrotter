//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Carlos Poles on 7/11/17.
//  Copyright © 2017 Carlos Poles. All rights reserved.
//

import UIKit


class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    // create outlet to the Celsius label and to the Text Field
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    // MARK: Computed Properties
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        // property observer to observe for changes so that
        // whenever the value of this property changes, the observer is triggered
        didSet {
            updateCelsiusLabel() // call the updateCelsiusLabel() method
                                // whenever the property is set
            print("celsius label updated.")
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    // number formatter to show value in celsius with one fractional digit precision
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    // MARK: Class Methods
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    // MARK: Action Methods
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        // check if text field contains any text and check as it changes
        // use number formatter to ensure conversion to Double using whichever decimal separator
        // use optional binding to check for values
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentDateTime = Date()
        let formattedDate = DateFormatter.localizedString(from: currentDateTime, dateStyle: .long, timeStyle: .long)
        print("The current date and time is: " + formattedDate)
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: currentDateTime)
        
        if (hour < 6 || hour > 18) { view.backgroundColor = UIColor.darkGray; textField.backgroundColor = UIColor.white }
        
    }
    
    // MARK: Delegation
    
    // use this function to validate the text as the user enters it
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // If the existing string has a decimal separator and the replacement string has a decimal separator
        // reject the change
        
        // use Locale to ensure that textField ignore more than one decimal separator no matter which locale
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        // reject alphabetic characters
        let alphabetic = CharacterSet.letters
        let replacementTextHasLetters = string.rangeOfCharacter(from: alphabetic)
        
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || replacementTextHasLetters != nil {
            return false // do not accept changes if there is a decimal point in the string
        } else {
            return true
        }
        
    }
    
}

