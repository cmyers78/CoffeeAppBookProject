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
    
    var delegate : TimerEditViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        coffeeTimers = [
            CoffeeTimerModel(name: "Colombian", duration: 240, type: .Coffee),
            CoffeeTimerModel(name: "Mexican", duration: 200, type: .Coffee)
        ]
        
        teaTimers = [
        
            CoffeeTimerModel(name: "Green Tea", duration: 400, type: .Tea),
            CoffeeTimerModel(name: "Oolong", duration: 400, type: .Tea),
            CoffeeTimerModel(name: "Rooibos", duration: 480, type: .Tea)
        ]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if presentedViewController != nil {
            tableView.reloadData()
        }
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard tableView.editing else {return}
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier("editDetail", sender: cell)
        
        
    }
   
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if indexPath.section == 0 {
                coffeeTimers.removeAtIndex(indexPath.row)
            } else {
                teaTimers.removeAtIndex(indexPath.row)
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
   
    override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        if action == #selector(NSObject.copy(_:)) {
            return true
        }
        
        return false
    }
    
    override func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        
        let timerModel : CoffeeTimerModel = {
            if indexPath.section == 0 {
                return self.coffeeTimers[indexPath.row]
            } else {
                return self.teaTimers[indexPath.row]
            }
        } ()
        
        
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.string = timerModel.name
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
        if let cell = sender as? UITableViewCell{
            let indexPath = tableView.indexPathForCell(cell)!
            
            let timerModel : CoffeeTimerModel = {
                if indexPath.section == 0 {
                    return self.coffeeTimers[indexPath.row]
                } else {
                    return self.teaTimers[indexPath.row]
                }
            } ()
            
            if segue.identifier == "pushDetail" {
            
            let detailViewController = segue.destinationViewController as! TimerDetailViewController
                detailViewController.timerModel = timerModel
            } else if segue.identifier == "editDetail" {
                let navigationController = segue.destinationViewController as! UINavigationController
                let editViewController = navigationController.topViewController as! TimerEditViewController
                editViewController.timerModel = timerModel
                //editViewController.delegate = self
                
            
            } else if let _ = sender as? UIBarButtonItem {
                if segue.identifier == "newTimer" {
                    let navigationController = segue.destinationViewController as! UINavigationController
                    let editViewController = navigationController.topViewController as! TimerEditViewController
                    
                    editViewController.creatingNewTimer = true
                    editViewController.timerModel = CoffeeTimerModel(name: "", duration: 240, type: .Coffee)
                    //editViewController.delegate = self
                    
                }
            }
        }
    }
}

extension TimerListTableViewController : TimerEditViewControllerDelegate {
    
    func timerEditViewControllerDidCancel(viewController: TimerEditViewController) {
        
    }
    
    func timerEditViewControllerDidSave(viewController : TimerEditViewController) {
        let model = viewController.timerModel
        let type = model?.type
        
        if type == .Coffee {
            if !coffeeTimers.contains(model!) {
                coffeeTimers.append(model!)
            }
            
            teaTimers = teaTimers.filter({ (item) -> Bool in
                return item != model
            
            })
        } else { // Type must be .Tea
            if !teaTimers.contains(model!) {
                teaTimers.append(model!)
            }
            
            coffeeTimers = coffeeTimers.filter({ (item) -> Bool in
                return item != model
            })
    }
    
    }
}