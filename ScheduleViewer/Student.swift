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
    var id = ""
    var monday = [Schedule]()
    var tuesday = [Schedule]()
    var wednesday = [Schedule]()
    var thursday = [Schedule]()
    var friday = [Schedule]()
    var saturday = [Schedule]()
    var user:Int = 0
//    var checked = false
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
         aCoder.encodeObject(id, forKey: "ID")
        aCoder.encodeObject(monday, forKey: "Monday")
        aCoder.encodeObject(tuesday, forKey: "Tuesday")
        aCoder.encodeObject(wednesday, forKey: "Wednesday")
        aCoder.encodeObject(thursday, forKey: "Thursday")
        aCoder.encodeObject(friday, forKey: "Friday")
        aCoder.encodeObject(saturday, forKey: "Saturday")
        aCoder.encodeObject(user, forKey: "User")
        //aCoder.encodeObject(schedule, forKey: "Schedule")
//        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        id = aDecoder.decodeObjectForKey("ID") as String
        monday = aDecoder.decodeObjectForKey("Monday") as [Schedule]
        tuesday = aDecoder.decodeObjectForKey("Tuesday") as [Schedule]
        wednesday = aDecoder.decodeObjectForKey("Wednesday") as [Schedule]
        thursday = aDecoder.decodeObjectForKey("Thursday") as [Schedule]
        friday = aDecoder.decodeObjectForKey("Friday") as [Schedule]
        saturday = aDecoder.decodeObjectForKey("Saturday") as [Schedule]
        user = aDecoder.decodeObjectForKey("User") as Int
        //schedule = aDecoder.decodeObjectForKey("Schedule") as [Schedule]
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