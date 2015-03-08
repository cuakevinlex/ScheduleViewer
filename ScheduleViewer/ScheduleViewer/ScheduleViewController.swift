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
    
    required init(coder aDecoder: NSCoder) {
        self.schedules = [Schedule]()
        
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
        
        println("Documents folder is \(documentsDirectory())")
        println("Data file path is \(dataFilePath())")
    }
    
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Schedules.plist")
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
    
    
    @IBAction func add(sender: AnyObject) {
        let newRowIndex = self.schedules.count
        
        let schedule = Schedule()
        schedule.name = "I am gay."
        self.schedules.append(schedule)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schedules.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Schedule") as UITableViewCell
        
        let schedule = schedules[indexPath.row]
        
        configureTextForCell(cell, withSchedule: schedule)
        //configureCheckmarkForCell(cell, withSchedule: schedule)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let schedule = schedules[indexPath.row]
            //Schedule.toggleChecked()
            
            //  configureCheckmarkForCell(cell, withChecklistSchedule: Schedule)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        saveSchedules()
    }
    /*
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistSchedule Schedule: ChecklistSchedule) {
    let label = cell.viewWithTag(1001) as UILabel
    if Schedule.checked {
    label.text = "√"
    } else {
    label.text = ""
    }
    }
    */
    func configureTextForCell(cell: UITableViewCell, withSchedule schedule: Schedule) {
        let label = cell.viewWithTag(1000) as UILabel
        label.text = schedule.name
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        schedules.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveSchedules()
    }
    
    func scheduleEditorViewControllerDidCancel(controller: ScheduleEditorViewController) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func scheduleEditorViewController(controller: ScheduleEditorViewController, didFinishAddingSchedule schedule: Schedule) {
        let newRowIndex = schedules.count
        schedules.append(schedule)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0);
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
        saveSchedules()
        
    }
    
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
        
        if segue.identifier == "EditSchedule" {
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                controller.scheduleToEdit = schedules[indexPath.row]
            }
        }
    }
}

