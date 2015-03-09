//
//  Student.swift
//  ScheduleViewer
//
//  Created by Wilbert Uy Jr. on 3/2/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import Foundation

class Student : NSObject, NSCoding {
    var name = ""
    var schedule = [Schedule]()
//    var checked = false
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(schedule, forKey: "Schedule")
//        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        schedule = aDecoder.decodeObjectForKey("Schedule") as [Schedule]
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