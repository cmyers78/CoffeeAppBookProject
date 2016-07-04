//
//  TimerEditViewController.swift
//  firstAppBook
//
//  Created by Christopher Myers on 7/2/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

@objc protocol TimerEditViewControllerDelegate {
    func timerEditViewControllerDidCancel(viewController : TimerEditViewController)
    func timerEditViewControllerDidSave(viewController : TimerEditViewController)
    
}

class TimerEditViewController: UIViewController {
    
    var timerModel : CoffeeTimerModel?
    weak var delegate : TimerEditViewControllerDelegate?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var minutesSlider: UISlider!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var secondsSlider: UISlider!
    @IBOutlet weak var timerTypeSegmentedControl: UISegmentedControl!
    
    var creatingNewTimer = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let timerModel = timerModel {
        let numberOfMinutes = Int(timerModel.duration / 60)
        let numberOfSeconds = Int(timerModel.duration % 60)
        nameField.text = timerModel.name
        updateLabelsWithMinutes(numberOfMinutes, seconds: numberOfSeconds)
        minutesSlider.value = Float(numberOfMinutes)
        secondsSlider.value = Float(numberOfSeconds)
        }
        
        switch timerModel?.type {
        case .Coffee?:
            timerTypeSegmentedControl.selectedSegmentIndex = 0
        case .Tea?:
            timerTypeSegmentedControl.selectedSegmentIndex = 1
        }
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelWasPressed(sender: UIBarButtonItem) {
        delegate?.timerEditViewControllerDidCancel(self)
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func doneWasPressed(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        timerModel?.name = nameField.text ?? ""
        timerModel?.duration = Int(minutesSlider.value) * 60 + Int(secondsSlider.value)
        
        if timerTypeSegmentedControl.selectedSegmentIndex == 0 {
            timerModel?.type = .Coffee
        } else {
            timerModel?.type = .Tea
        }
        delegate?.timerEditViewControllerDidSave(self)
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


}
    