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
    
    var scheduleToEdit: Schedule?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let item = scheduleToEdit {
            title = "Edit Schedule"
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
        if let schedule = scheduleToEdit {
            schedule.name = textField.text
            delegate?.scheduleEditorViewController(self, didFinishEditingSchedule: schedule)
        }
        
    }
    
    
}