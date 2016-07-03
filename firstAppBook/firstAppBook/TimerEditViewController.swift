//
//  TimerEditViewController.swift
//  firstAppBook
//
//  Created by Christopher Myers on 7/2/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class TimerEditViewController: UIViewController {
    
    var timerModel : CoffeeTimerModel!
    
    @IBOutlet weak var nameField: UITextField!

    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var minutesSlider: UISlider!
    
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var secondsSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberOfMinutes = Int(timerModel.duration / 60)
        let numberOfSeconds = Int(timerModel.duration % 60)
        nameField.text = timerModel.name
        updateLabelsWithMinutes(numberOfMinutes, seconds: numberOfSeconds)
        minutesSlider.value = Float(numberOfMinutes)
        secondsSlider.value = Float(numberOfSeconds)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelWasPressed(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneWasPressed(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        timerModel.name = nameField.text ?? ""
        timerModel.duration = Int(minutesSlider.value) * 60 + Int(secondsSlider.value)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func updateLabelsWithMinutes(minutes: Int, seconds : Int) {
        
        func pluralize(value: Int, singular: String, plural: String) -> String {
            switch value {
            case 1:
                return "1 \(singular)"
            case let pluralValue:
                return "\(pluralValue) \(plural)"
            }
        }
        
        minutesLabel.text = pluralize(minutes, singular: "minute", plural: "minutes")
        secondsLabel.text = pluralize(seconds, singular: "second", plural: "seconds")
        
    }
    @IBAction func sliderValueChanged(sender: AnyObject) {
        
        let numberOfMinutes = Int(minutesSlider.value)
        let numberOfSeconds = Int(secondsSlider.value)
        updateLabelsWithMinutes(numberOfMinutes, seconds: numberOfSeconds)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
