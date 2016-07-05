//
//  TimerDetailViewController.swift
//  firstAppBook
//
//  Created by Christopher Myers on 7/1/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class TimerDetailViewController: UIViewController {
    
    var timerModel : CoffeeTimerModel!
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var timer = NSTimer?()
    var notification: UILocalNotification?
    
    
    var timeRemaining : NSInteger {
        guard let fireDate = notification?.fireDate else {
            return 0
        }
        
        let now = NSDate()
        return NSInteger(round(fireDate.timeIntervalSinceDate(now)))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = timerModel.name
        self.durationLabel.text = "\(timerModel.duration / 60) min \(timerModel.duration % 60) sec"
        
        self.countdownLabel.text = "Timer not started"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerFired() {
        
        if timeRemaining > 0 {
            countdownLabel.text = String(format: "%d:%02d",
            timeRemaining / 60, timeRemaining % 60)
            
        } else {
            stopTimer(.Completed)        }
    }
    
    func startTimer() {
        navigationItem.setHidesBackButton(true, animated: true)
        startStopButton.setTitle("Stop", forState: .Normal)
        
        //timeRemaining = timerModel.duration
        countdownLabel.text = String(format: "%d:%02d", timeRemaining / 60, timeRemaining % 60)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TimerDetailViewController.timerFired), userInfo: nil, repeats: true)
        
        let localNotification = UILocalNotification()
        localNotification.alertBody = "Timer Completed!"
        localNotification.fireDate =
            NSDate().dateByAddingTimeInterval(NSTimeInterval(timerModel.duration))
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        notification = localNotification
    }
    
    enum StopTimerReason {
        // reasons (cases) why timer could be stopped
        case Cancelled
        case Completed
        
        // message that shows when timer is stopped and logic of which case to use
        func message() -> String {
            switch self {
            case .Cancelled:
                return "Timer Cancelled"
            case .Completed:
                return "Timer Completed"
            }
        }
    }
    
    func stopTimer(reason : StopTimerReason) {
        navigationItem.setHidesBackButton(false, animated: true)
        countdownLabel.text = reason.message()
        startStopButton.setTitle("Start", forState: .Normal)
        timer?.invalidate()
        timer = nil
        
        if reason == .Cancelled {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
        notification = nil
    }
    
    @IBAction func buttonWasPressed(sender: UIButton) {
        print("Button was pressed")
        
        if let _ = timer {
            stopTimer(.Cancelled)
            
        } else {
            startTimer()
        }
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
