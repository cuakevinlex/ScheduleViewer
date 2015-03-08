//
//  Schedule.swift
//  ScheduleViewer
//
//  Created by Wilbert Uy Jr. on 3/4/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import UIKit

class Schedule : NSObject, NSCoding {
    var name = ""
    //    var checked = false
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        //        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        //        checked =  aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
}