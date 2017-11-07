//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Carlos Poles on 7/11/17.
//  Copyright © 2017 Carlos Poles. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController {
    
    // create outlet to the Celsius label
    @IBOutlet var celsiusLabel: UILabel!
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        // check if text field contains any text
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = text
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    
    
}

