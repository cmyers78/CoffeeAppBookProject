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
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
