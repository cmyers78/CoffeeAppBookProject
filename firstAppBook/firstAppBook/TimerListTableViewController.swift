//
//  TimerListTableViewController.swift
//  firstAppBook
//
//  Created by Christopher Myers on 7/3/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class TimerListTableViewController: UITableViewController {
    
    var coffeeTimers : [CoffeeTimerModel]!
    var teaTimers : [CoffeeTimerModel]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        coffeeTimers = [
            CoffeeTimerModel(name: "Colombian", duration: 240),
            CoffeeTimerModel(name: "Mexican", duration: 200)
        ]
        
        teaTimers = [
        
            CoffeeTimerModel(name: "Green Tea", duration: 400),
            CoffeeTimerModel(name: "Oolong", duration: 400),
            CoffeeTimerModel(name: "Rooibos", duration: 480)
        ]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return coffeeTimers.count
        } else {
            return teaTimers.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let timerModel: CoffeeTimerModel = {
        
        if indexPath.section == 0 {
            return self.coffeeTimers[indexPath.row]
        } else {
            return self.teaTimers[indexPath.row]
        }
        
        }()
        
        cell.textLabel?.text = timerModel.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Coffees"
        } else {
            return "Teas"
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "pushDetail" {
            if tableView.editing {
                return false
            }
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pushDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let timerModel : CoffeeTimerModel = {
                if indexPath.section == 0 {
                    return self.coffeeTimers[indexPath.row]
                } else {
                    return self.teaTimers[indexPath.row]
                }
            } ()
            
            
            let detailViewController = segue.destinationViewController as! TimerDetailViewController
            detailViewController.timerModel = timerModel
            
        }
    }
}
