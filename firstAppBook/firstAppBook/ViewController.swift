//
//  ViewController.swift
//  firstAppBook
//
//  Created by Christopher Myers on 6/30/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var timerModel : CoffeeTimerModel! {
        willSet(newModel) {
            print("About to change mode to \(newModel)")
        }
        
        didSet {
            print("Set model to \(timerModel)")
            updateUserInterface()
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Root"
        
        
        self.setupModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupModel() {
        self.timerModel = CoffeeTimerModel(coffeeName: "Columbian", duration: 240)
        
    }
    
    func updateUserInterface() {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Preparing for segue with identifier:\(segue.identifier)")
        
            if segue.identifier == "pushDetail" {
            let viewController = segue.destinationViewController as! TimerDetailViewController
                
                viewController.timerModel = timerModel
            
            } else if segue.identifier == "editDetail" {
                let navigationController = segue.destinationViewController as! UINavigationController
                let viewController = navigationController.topViewController as! TimerEditViewController
                viewController.timerModel = timerModel
                
        }
    }

}

