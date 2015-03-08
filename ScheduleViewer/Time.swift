//
//  Time.swift
//  ScheduleViewer
//
//  Created by KevinCua on 3/8/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import Foundation

class Time : NSObject, NSCoding {
    var time = ""
    //    var checked = false
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(time, forKey: "Time")
        //        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        time = aDecoder.decodeObjectForKey("Time") as String
        //        checked =  aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    //    func toggleChecked() {
    //        checked = !checked
    //    }
}