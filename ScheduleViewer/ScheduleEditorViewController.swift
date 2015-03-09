//
//  ScheduleEditorViewController.swift
//  ScheduleViewer
//
//  Created by Wilbert Uy Jr. on 3/4/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import UIKit
protocol ScheduleEditorViewControllerDelegate:class{
    func scheduleEditorViewControllerDidCancel(ScheduleEditorViewController:ScheduleEditorViewController)
    /*func scheduleEditorViewController(ScheduleEditorViewController:ScheduleEditorViewController, didFinishAddingSchedule schedule:Schedule)*/
    func scheduleEditorViewController(ScheduleEditorViewController:ScheduleEditorViewController, didFinishEditingSchedule schedule: Schedule)
}


class ScheduleEditorViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate:ScheduleEditorViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
     var mondayToEdit: Schedule?
     var tuesdayToEdit: Schedule?
     var wednesdayToEdit: Schedule?
     var thursdayToEdit: Schedule?
     var fridayToEdit: Schedule?
     var saturdayToEdit: Schedule?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let item = mondayToEdit {
            title = "Monday"
            textField.text = item.name
        }else if let item = tuesdayToEdit {
            title = "Tuesday"
            textField.text = item.name
        }else if let item = wednesdayToEdit {
            title = "Wednesday"
            textField.text = item.name
        }else if let item = thursdayToEdit {
            title = "Thursday"
            textField.text = item.name
        }else if let item = fridayToEdit {
            title = "Friday"
            textField.text = item.name
        }else if let item = saturdayToEdit {
            title = "Saturday"
            textField.text = item.name
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText:NSString = textField.text
        let newText:NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if newText.length > 0 {
            doneBarButton.enabled = true
        } else {
            doneBarButton.enabled = false
        }
        return true
    }
    
    @IBAction func cancel(sender: AnyObject) {
        delegate?.scheduleEditorViewControllerDidCancel(self)
    }
    
    @IBAction func done(sender: AnyObject) {
        if let schedule = mondayToEdit{
            schedule.name = textField.text
            delegate?.scheduleEditorViewController(self, didFinishEditingSchedule: schedule)
        }else if let schedule = tuesdayToEdit {
            schedule.name = textField.text
            delegate?.scheduleEditorViewController(self, didFinishEditingSchedule: schedule)
        }else if let schedule = wednesdayToEdit {
            schedule.name = textField.text
            delegate?.scheduleEditorViewController(self, didFinishEditingSchedule: schedule)
        }else if let schedule = thursdayToEdit {
            schedule.name = textField.text
            delegate?.scheduleEditorViewController(self, didFinishEditingSchedule: schedule)
        }else if let schedule = fridayToEdit {
            schedule.name = textField.text
            delegate?.scheduleEditorViewController(self, didFinishEditingSchedule: schedule)
        }else if let schedule = saturdayToEdit {
            schedule.name = textField.text
            delegate?.scheduleEditorViewController(self, didFinishEditingSchedule: schedule)
        }
        
    }
    
    
}