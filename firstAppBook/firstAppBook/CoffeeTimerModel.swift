//
//  CoffeeTimerModel.swift
//  firstAppBook
//
//  Created by Christopher Myers on 6/30/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class CoffeeTimerModel: NSObject {
    
    var name : String = ""
    var duration : Int = 0
    
    override init() {
        super.init()
        
    }
    
    init(name : String, duration: Int) {
        super.init()
        self.name = name
        self.duration = duration
    }
    
    override var description: String {
        get {
            return "CoffeTimerModel(\(name)"
        }
    }

}
