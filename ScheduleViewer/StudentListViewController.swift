//
//  StudentListViewController.swift
//  ScheduleViewer
//
//  Created by Wilbert Uy Jr. on 3/2/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import UIKit

class StudentListViewController: UITableViewController, StudentEditorViewControllerDelegate{
    
    var students:[Student]
    
    required init(coder aDecoder: NSCoder) {
        self.students = [Student]()
        
        super.init(coder: aDecoder)
        loadStudents()
    }
    
    func loadStudents() {
        // 1
        let path = dataFilePath()
        // 2
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            // 3
            let data = NSData(contentsOfFile: path)
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            students = unarchiver.decodeObjectForKey("Students") as [Student]
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
        return documentsDirectory().stringByAppendingPathComponent("Students.plist")
    }
    
    func saveStudents() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(students, forKey: "Students")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Student") as UITableViewCell
        
        let student = students[indexPath.row]
        
        configureTextForCell(cell, withStudent: student)
        //configureCheckmarkForCell(cell, withCheckliststudent: student)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let student = students[indexPath.row]
            //student.toggleChecked()
            
          //  configureCheckmarkForCell(cell, withCheckliststudent: student)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        saveStudents()
    }
    /*
    func configureCheckmarkForCell(cell: UITableViewCell, withCheckliststudent student: Checkliststudent) {
        let label = cell.viewWithTag(1001) as UILabel
        if student.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    */
    func configureTextForCell(cell: UITableViewCell, withStudent student: Student) {
        let label = cell.viewWithTag(1000) as UILabel
        label.text = student.name
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        students.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveStudents()
    }
    
    func studentEditorViewControllerDidCancel(controller: StudentEditorViewController) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func studentEditorViewController(controller: StudentEditorViewController, didFinishAddingStudent student: Student) {
        let newRowIndex = students.count
        students.append(student)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0);
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
        saveStudents()
        
    }
    
    func studentEditorViewController(controller: StudentEditorViewController, didFinishEditingStudent student: Student) {
        if let index = find(students, student) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withStudent: student)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        saveStudents()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "EditStudent" {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as StudentEditorViewController
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                controller.studentToEdit = students[indexPath.row]
            }
        }
        else if segue.identifier == "AddStudent"{
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as StudentEditorViewController
            controller.delegate = self
        }
        else if segue.identifier == "CheckSchedule"{
            var myTabBarController:CustomTabBarController = segue.destinationViewController as CustomTabBarController
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                myTabBarController.student = students[indexPath.row]
            }
        }
        
        
    }
}

