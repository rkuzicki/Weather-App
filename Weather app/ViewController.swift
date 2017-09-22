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
            let weatherUrlString = "http://www.weather-forecast.com/locations/" + cityModified + "/forecasts/latest"
            
            let weatherUrl = URL(string: weatherUrlString)
            let weatherRequest = NSMutableURLRequest(url: weatherUrl!)
            let weatherTask = URLSession.shared.dataTask(with: weatherRequest as URLRequest) {
                data, response, error in
                if (error != nil) {
                    self.weatherResult.text = "An error occured. "
                }
                else {
                    if let weatherData = data {
                        let weatherDataString = NSString(data: weatherData, encoding: String.Encoding.utf8.rawValue)
                        DispatchQueue.main.sync {
                            if (weatherDataString!.contains("404")){
                                self.weatherResult.text = "There is no city called " + self.userInput.text!
                            }
                            else {
                                let separator = "<span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                                if let content = weatherDataString?.components(separatedBy: separator) {
                                    let separator_2 = "</span></span></span></p>"
                                    let message = content[1].components(separatedBy: separator_2)[0].replacingOccurrences(of: "&deg;", with: "°")
                                    self.weatherResult.text = message
                                }
                            }
                        }
                    }
                }
            }
            weatherTask.resume()
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

