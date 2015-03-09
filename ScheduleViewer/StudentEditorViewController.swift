//
//  StudentEditorViewController.swift
//  ScheduleViewer
//
//  Created by Wilbert Uy Jr. on 3/2/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import UIKit

protocol StudentEditorViewControllerDelegate:class{
    func studentEditorViewControllerDidCancel(StudentEditorViewController:StudentEditorViewController)
    func studentEditorViewController(StudentEditorViewController:StudentEditorViewController, didFinishAddingStudent student:Student)
    func studentEditorViewController(StudentEditorViewController:StudentEditorViewController, didFinishEditingStudent student: Student)
}


class StudentEditorViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate:StudentEditorViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let item = studentToEdit {
            title = "Edit Student"
            textField.text = item.name
        }
        
    }
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    var studentToEdit: Student?
    
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
        delegate?.studentEditorViewControllerDidCancel(self)
    }
    
    @IBAction func done(sender: AnyObject) {
        if let student = studentToEdit {
            student.name = textField.text
            delegate?.studentEditorViewController(self, didFinishEditingStudent: student)
        } else {
            let student = Student()
            student.id = textField.text
            student.name = textField.text
            delegate?.studentEditorViewController(self, didFinishAddingStudent: student)
        }
        
    }
    
    
}
