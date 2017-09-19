//
//  ViewController.swift
//  Weather app
//
//  Created by Radoslaw Kuzicki on 19/09/2017.
//  Copyright © 2017 radek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var weatherResult: UILabel!

    @IBAction func submit(_ sender: Any) {
        if let city = userInput.text, !city.isEmpty {
            let cityModified = city.components(separatedBy: " ").joined()
            let weatherUrl = "http://www.weather-forecast.com/locations/" + cityModified + "/forecasts/latest"
            weatherResult.text = weatherUrl
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "amanda-sandlin-10508.jpg")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

