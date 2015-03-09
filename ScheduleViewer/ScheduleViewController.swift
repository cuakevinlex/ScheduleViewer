//
//  ScheduleViewController.swift
//  ScheduleViewer
//
//  Created by Wilbert Uy Jr. on 3/2/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController, ScheduleEditorViewControllerDelegate{

    var schedules:[Schedule]
    var monday:[Schedule]
    var tuesday:[Schedule]
    var wednesday:[Schedule]
    var thursday:[Schedule]
    var friday:[Schedule]
    var saturday:[Schedule]
    var monday1:[Schedule]
    var tuesday1:[Schedule]
    var wednesday1:[Schedule]
    var thursday1:[Schedule]
    var friday1:[Schedule]
    var saturday1:[Schedule]
    var student:Student
    required init(coder aDecoder: NSCoder) {
        self.schedules = [Schedule]()
        self.monday = [Schedule]()
        self.tuesday = [Schedule]()
        self.wednesday = [Schedule]()
        self.thursday = [Schedule]()
        self.friday = [Schedule]()
        self.saturday = [Schedule]()
        self.monday1 = [Schedule]()
        self.tuesday1 = [Schedule]()
        self.wednesday1 = [Schedule]()
        self.thursday1 = [Schedule]()
        self.friday1 = [Schedule]()
        self.saturday1 = [Schedule]()
        self.student=Student()
        super.init(coder: aDecoder)
        //loadSchedules()
    }
    
    func loadSchedules() {
        // 1
        let path = dataFilePath()
        // 2
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            // 3
            let data = NSData(contentsOfFile: path)
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            monday1 = unarchiver.decodeObjectForKey("Monday") as [Schedule]
            tuesday1 = unarchiver.decodeObjectForKey("Tuesday") as [Schedule]
            wednesday1 = unarchiver.decodeObjectForKey("Wednesday") as [Schedule]
            thursday1 = unarchiver.decodeObjectForKey("Thursday") as [Schedule]
            friday1 = unarchiver.decodeObjectForKey("Friday") as [Schedule]
            saturday1 = unarchiver.decodeObjectForKey("Saturday") as [Schedule]
            unarchiver.finishDecoding()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          configureTimeslotForCell()
        var myTabController = self.tabBarController as CustomTabBarController
        self.student = myTabController.student!
        //self.schedules = student.schedule
        
        loadSchedules()
        if monday1.count == 12 {
            monday = monday1
        }
        if tuesday1.count == 9{
            tuesday = tuesday1
        }
        if wednesday1.count == 12{
            wednesday = wednesday1
        }
        if thursday1.count == 9{
            thursday = thursday1
        }
        if friday1.count == 12 {
            friday = friday1
        }
        if saturday1.count == 2{
            saturday =  saturday1
        }
        

        // Do any additional setup after loading the view, typically from a nib.
      
        println("Documents folder is \(documentsDirectory())")
        println("Data file path is \(dataFilePath())")
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var myTabController = self.tabBarController as CustomTabBarController
        
        var day = "Day"
        
        if self.tabBarController?.selectedIndex == 0 {
            day = "Monday"
            self.title = "Monday"
        } else if self.tabBarController?.selectedIndex == 1 {
            day = "Tuesday"
            self.title = "Tuesday"
        } else if self.tabBarController?.selectedIndex == 2 {
            day = "Wednesday"
            self.title = "Wednesday"
        } else if self.tabBarController?.selectedIndex == 3 {
            day = "Thursday"
            self.title = "Thursday"
        } else if self.tabBarController?.selectedIndex == 4 {
            day = "Friday"
            self.title = "Friday"
        } else if self.tabBarController?.selectedIndex == 5 {
            day = "Saturday"
            self.title = "Saturday"
        }
        
        self.student = myTabController.student!
        //self.schedules = student.schedule
     
        var message = "\(day) schedule for \(student.name)"
        
        //var alert = UIAlertView(title: "Schedule", message: message, delegate: nil, cancelButtonTitle: "Okay")
        
        //alert.show()
        
    }

    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("\(student.id).plist")
    }
    
    func saveSchedules() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(monday, forKey: "Monday")
        archiver.encodeObject(tuesday, forKey: "Tuesday")
        archiver.encodeObject(wednesday, forKey: "Wednesday")
        archiver.encodeObject(thursday, forKey: "Thursday")
        archiver.encodeObject(friday, forKey: "Friday")
        archiver.encodeObject(saturday, forKey: "Saturday")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.title == "Monday" || self.title == "Wednesday" || self.title == "Friday" {
            return 12
        } else if self.title == "Tuesday" || self.title == "Thursday" {
            return 9
        } else {
            return 2
        }

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Schedule") as UITableViewCell
        var schedule = Schedule()
        
        if self.title == "Monday" {
            schedule = monday[indexPath.row]
        } else if self.title == "Tuesday" {
             schedule = tuesday[indexPath.row]
        } else if self.title == "Wednesday" {
             schedule = wednesday[indexPath.row]
        } else if self.title == "Thursday" {
             schedule = thursday[indexPath.row]
        } else if self.title == "Friday"{
             schedule = friday[indexPath.row]
        } else if self.title == "Saturday"{
             schedule = saturday[indexPath.row]
        }
        configureTimeForCell(cell, withSchedule: schedule)
        configureTextForCell(cell, withSchedule: schedule)
        
        
        return cell
    }
  
    func configureTextForCell(cell: UITableViewCell, withSchedule schedule:Schedule) {
        let label = cell.viewWithTag(1002) as UILabel
        label.text = schedule.name
        if schedule.name != ""
        {
            cell.backgroundColor  = UIColor.redColor()
        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor()
        }

        saveSchedules()
    }
    func configureTimeForCell(cell: UITableViewCell, withSchedule schedule:Schedule) {
        let label = cell.viewWithTag(1001) as UILabel
        label.text = schedule.time

        saveSchedules()
    }
    
    
    override func tableView (tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //implement: are you sure? before deleting
        // schedules.removeAtIndex(indexPath.row)
        if self.title == "Monday"{
            monday[indexPath.row].name = ""
        }else if self.title == "Tuesday"{
            tuesday[indexPath.row].name = ""
        }else if self.title == "Wednesday"{
            wednesday[indexPath.row].name = ""
        }else if self.title == "Thursday"{
            thursday[indexPath.row].name = ""
        }else if self.title == "Friday"{
            friday[indexPath.row].name = ""
        }else if self.title == "Saturday"{
            saturday[indexPath.row].name = ""
        }
        let indexPaths = [indexPath]
        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveSchedules()
    }

    
    func scheduleEditorViewControllerDidCancel(controller: ScheduleEditorViewController) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    /*
    func scheduleEditorViewController(controller: ScheduleEditorViewController, didFinishAddingSchedule schedule: Schedule) {
        let newRowIndex = schedules.count
        schedules.append(schedule)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0);
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
        saveSchedules()
        
    }
    */
    func scheduleEditorViewController(controller: ScheduleEditorViewController, didFinishEditingSchedule schedule: Schedule) {
        if self.title == "Monday"{
            if let index = find(monday, schedule) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withSchedule: schedule)
                    configureTimeForCell(cell, withSchedule: schedule)
                }
            }
        }else if self.title == "Tuesday"{
            if let index = find(tuesday, schedule) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withSchedule: schedule)
                    configureTimeForCell(cell, withSchedule: schedule)
                }
            }
        }else if self.title == "Wednesday"{
            if let index = find(wednesday, schedule) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withSchedule: schedule)
                    configureTimeForCell(cell, withSchedule: schedule)
                }
            }
        }else if self.title == "Thursday"{
            if let index = find(thursday, schedule) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withSchedule: schedule)
                    configureTimeForCell(cell, withSchedule: schedule)
                }
            }
        }else if self.title == "Friday"{
            if let index = find(friday, schedule) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withSchedule: schedule)
                    configureTimeForCell(cell, withSchedule: schedule)
                }
            }
        }else if self.title == "Saturday"{
            if let index = find(saturday, schedule) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withSchedule: schedule)
                    configureTimeForCell(cell, withSchedule: schedule)
                }
            }
        }

        dismissViewControllerAnimated(true, completion: nil)
        saveSchedules()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let navigationController = segue.destinationViewController as UINavigationController
        let controller = navigationController.topViewController as ScheduleEditorViewController
        controller.delegate = self
        
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                if self.title == "Monday"{
                controller.mondayToEdit = monday[indexPath.row]
                }else if self.title == "Tuesday"{
                controller.tuesdayToEdit = tuesday[indexPath.row]
                }else if self.title == "Wednesday"{
                controller.wednesdayToEdit = wednesday[indexPath.row]
                }else if self.title == "Thursday"{
                controller.thursdayToEdit = thursday[indexPath.row]
                }else if self.title == "Friday"{
                controller.fridayToEdit = friday[indexPath.row]
                }else if self.title == "Saturday"{
                controller.saturdayToEdit = saturday[indexPath.row]
                }
            }
        
    }
    func configureTimeslotForCell() {
        
        //create if else for mwf, tth, sat
        
        
        
        //if self.tabBarController?.selectedIndex == 9223372036854775807 || self.tabBarController?.selectedIndex == 1 || self.tabBarController?.selectedIndex == 4 {
        if self.title == "Monday" {
            
            for var i = 0; i < 12; i++
            {
                
                // let newRowIndex = self.schedules.count
                let item = Schedule()
                
                if i == 0 {
                    item.time = "7:30 - 8:30"
                    // item.time = toString(self.tabBarController?.selectedIndex)
                    //item.subject = ""
                } else if i ==  1 {
                    item.time = "8:30 - 9:30"
                } else if i ==  2 {
                    item.time = "9:30 - 10:30"
                } else if i ==  3 {
                    item.time = "10:30 - 11:30"
                } else if i ==  4 {
                    item.time = "11:30 - 12:30"
                } else if i ==  5 {
                    item.time = "12:30 - 1:30"
                } else if i ==  6 {
                    item.time = "1:30 - 2:30"
                } else if i ==  7 {
                    item.time = "2:30 - 3:30"
                } else if i ==  8 {
                    item.time = "3:30 - 4:30"
                } else if i ==  9 {
                    item.time = "4:30 - 5:30"
                } else if i ==  10 {
                    item.time = "5:30 - 6:30"
                } else if i ==  11 {
                    item.time = "6:00 - 9:00"
                }
                
                
                self.monday.append(item)
                
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        if self.title == "Wednesday" {
            
            for var i = 0; i < 12; i++
            {
                
                // let newRowIndex = self.schedules.count
                let item = Schedule()
                
                if i == 0 {
                    item.time = "7:30 - 8:30"
                    // item.time = toString(self.tabBarController?.selectedIndex)
                    //item.subject = ""
                } else if i ==  1 {
                    item.time = "8:30 - 9:30"
                } else if i ==  2 {
                    item.time = "9:30 - 10:30"
                } else if i ==  3 {
                    item.time = "10:30 - 11:30"
                } else if i ==  4 {
                    item.time = "11:30 - 12:30"
                } else if i ==  5 {
                    item.time = "12:30 - 1:30"
                } else if i ==  6 {
                    item.time = "1:30 - 2:30"
                } else if i ==  7 {
                    item.time = "2:30 - 3:30"
                } else if i ==  8 {
                    item.time = "3:30 - 4:30"
                } else if i ==  9 {
                    item.time = "4:30 - 5:30"
                } else if i ==  10 {
                    item.time = "5:30 - 6:30"
                } else if i ==  11 {
                    item.time = "6:00 - 9:00"
                }
                
                
                self.wednesday.append(item)
                
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        if self.title == "Friday" {
            
            for var i = 0; i < 12; i++
            {
                
                // let newRowIndex = self.schedules.count
                let item = Schedule()
                
                if i == 0 {
                    item.time = "7:30 - 8:30"
                    // item.time = toString(self.tabBarController?.selectedIndex)
                    //item.subject = ""
                } else if i ==  1 {
                    item.time = "8:30 - 9:30"
                } else if i ==  2 {
                    item.time = "9:30 - 10:30"
                } else if i ==  3 {
                    item.time = "10:30 - 11:30"
                } else if i ==  4 {
                    item.time = "11:30 - 12:30"
                } else if i ==  5 {
                    item.time = "12:30 - 1:30"
                } else if i ==  6 {
                    item.time = "1:30 - 2:30"
                } else if i ==  7 {
                    item.time = "2:30 - 3:30"
                } else if i ==  8 {
                    item.time = "3:30 - 4:30"
                } else if i ==  9 {
                    item.time = "4:30 - 5:30"
                } else if i ==  10 {
                    item.time = "5:30 - 6:30"
                } else if i ==  11 {
                    item.time = "6:00 - 9:00"
                }
                
                
                self.friday.append(item)
                
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        
        
        
        //tth
        // if self.tabBarController?.selectedIndex == 0 || self.tabBarController?.selectedIndex == 2  {
        if self.title == "Tuesday"{
            for var i = 0; i < 9; i++
            {
                
                let newRowIndex = self.schedules.count
                let item = Schedule()
                
                if i == 0 {
                    item.time = "7:30 - 9:00"
                    //item.subject = ""
                } else if i ==  1 {
                    item.time = "9:00 - 10:30"
                } else if i ==  2 {
                    item.time = "10:30 - 12:00"
                } else if i ==  3 {
                    item.time = "12:00 - 1:30"
                } else if i ==  4 {
                    item.time = "1:30 - 3:00"
                } else if i ==  5 {
                    item.time = "3:00 - 4:30"
                } else if i ==  6 {
                    item.time = "4:30 - 6:00"
                } else if i ==  7 {
                    item.time = "6:00 - 7:30"
                } else if i ==  8 {
                    item.time = "6:00 - 9:00"
                }
                
                
                self.tuesday.append(item)
                
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        if self.title == "Thursday" {
            for var i = 0; i < 9; i++
            {
                
                let newRowIndex = self.schedules.count
                let item = Schedule()
                
                if i == 0 {
                    item.time = "7:30 - 9:00"
                    //item.subject = ""
                } else if i ==  1 {
                    item.time = "9:00 - 10:30"
                } else if i ==  2 {
                    item.time = "10:30 - 12:00"
                } else if i ==  3 {
                    item.time = "12:00 - 1:30"
                } else if i ==  4 {
                    item.time = "1:30 - 3:00"
                } else if i ==  5 {
                    item.time = "3:00 - 4:30"
                } else if i ==  6 {
                    item.time = "4:30 - 6:00"
                } else if i ==  7 {
                    item.time = "6:00 - 7:30"
                } else if i ==  8 {
                    item.time = "6:00 - 9:00"
                }
                
                
                self.thursday.append(item)
                
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        
        //sat
        // if self.tabBarController?.selectedIndex == 5 {
        if self.title == "Saturday" {
            for var i = 0; i < 2; i++
            {
                
                //  let newRowIndex = self.schedules.count
                let item = Schedule()
                
                //if newRowIndex == 0
                if i == 0 {
                    item.time = "9:00-12:00"
                    //item.subject = ""
                } else if i == 1 {
                    item.time = "1:30-4:30"
                }
                self.saturday.append(item)
                
                //let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        
        saveSchedules()
    }



}

