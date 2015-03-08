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
    var time:[Time]
    var student:Student
    required init(coder aDecoder: NSCoder) {
        self.schedules = [Schedule]()
        self.time = [Time]()
        student=Student()
        super.init(coder: aDecoder)
        loadSchedules()
    }
    
    func loadSchedules() {
        // 1
        let path = dataFilePath()
        // 2
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            // 3
            let data = NSData(contentsOfFile: path)
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            schedules = unarchiver.decodeObjectForKey("Schedules") as [Schedule]
            unarchiver.finishDecoding()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
        configureTimeslotForCell()
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
        } else if self.tabBarController?.selectedIndex == 1 {
            day = "Tuesday"
        } else if self.tabBarController?.selectedIndex == 2 {
            day = "Wednesday"
        } else if self.tabBarController?.selectedIndex == 3 {
            day = "Thursday"
        } else if self.tabBarController?.selectedIndex == 4 {
            day = "Friday"
        } else if self.tabBarController?.selectedIndex == 5 {
            day = "Saturday"
        }
        
        self.student = myTabController.student!
        
        var message = "\(day) schedule for \(student.name)"
        
        var alert = UIAlertView(title: "Schedule", message: message, delegate: nil, cancelButtonTitle: "Okay")
        
        alert.show()
        
    }

    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("\(student.name).plist")
    }
    
    func saveSchedules() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(schedules, forKey: "Schedules")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.title == "Monday" || self.title == "Wednesday" || self.title == "Friday" {
            return 11
        } else if self.title == "Tuesday" || self.title == "Thursday" {
            return 9
        } else {
            return 2
        }

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Schedule") as UITableViewCell
        let schedule = schedules[indexPath.row]
        //let schedule = schedules[indexPath.row]
        //configureTimeForCell(cell, withTime: currTime)
        //configureTextForCell(cell, withSchedule: schedule)
        //configureCheckmarkForCell(cell, withSchedule: schedule)
        
        configureTimeForCell(cell, withTime: schedule)
        configureTextForCell(cell, withSchedule: schedule)
        
        return cell
    }
  
    func configureTextForCell(cell: UITableViewCell, withSchedule schedule: Schedule) {
        let label = cell.viewWithTag(1002) as UILabel
        label.text = schedule.name
        saveSchedules()
    }
    func configureTimeForCell(cell: UITableViewCell, withTime schedule:Schedule) {
        let label = cell.viewWithTag(1001) as UILabel
        label.text = schedule.time
        saveSchedules()
    }
    
    
    override func tableView (tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //implement: are you sure? before deleting
        // schedules.removeAtIndex(indexPath.row)
        schedules[indexPath.row].name = ""
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
        if let index = find(schedules, schedule) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withSchedule: schedule)
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
                controller.scheduleToEdit = schedules[indexPath.row]
            }
        
    }
    func configureTimeslotForCell() {
        
        //create if else for mwf, tth, sat
        
        
        
        //if self.tabBarController?.selectedIndex == 9223372036854775807 || self.tabBarController?.selectedIndex == 1 || self.tabBarController?.selectedIndex == 4 {
        if self.title == "Monday" || self.title == "Wednesday" || self.title == "Friday" {
            
            for var i = 0; i < 11; i++
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
                    item.time = "6 - 9"
                }
                
                
                self.schedules.append(item)
                
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        
        //tth
        // if self.tabBarController?.selectedIndex == 0 || self.tabBarController?.selectedIndex == 2  {
        if self.title == "Tuesday" || self.title == "Thursday" {
            for var i = 0; i < 9; i++
            {
                
                let newRowIndex = self.schedules.count
                let item = Schedule()
                
                if i == 0 {
                    item.time = "7:30-9:00"
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
                    item.time = "6 - 9"
                }
                
                
                self.schedules.append(item)
                
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        
        //sat
        // if self.tabBarController?.selectedIndex == 5 {
        if self.title == "Saturday" {
            for var i = 0; i < 1; i++
            {
                
                //  let newRowIndex = self.schedules.count
                let item = Schedule()
                
                //if newRowIndex == 0
                if i == 0 {
                    item.time = "9:00-12:00"
                    //item.subject = ""
                }
                self.schedules.append(item)
                
                //let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let indexPaths = [indexPath]
                
                
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
        
        saveSchedules()
    }



}

