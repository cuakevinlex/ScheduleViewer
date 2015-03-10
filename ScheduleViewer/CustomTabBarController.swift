//
//  CustomTabBarController.swift
//  ScheduleViewer
//
//  Created by KevinCua on 3/8/15.
//  Copyright (c) 2015 Ateneo de Manila University. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var student:Student?
    var students:[Student]?
    override func viewDidLoad() {
        super.viewDidLoad()
        let date:NSDate = NSDate()
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let dayOfWeekString = formatter.stringFromDate(date)
        println(dayOfWeekString)
        if dayOfWeekString == "Monday"{
            self.selectedIndex = 0
        } else if dayOfWeekString == "Tuesday"{
            self.selectedIndex = 1
        } else if dayOfWeekString == "Wednesday"{
            self.selectedIndex = 2
        } else if dayOfWeekString == "Thursday"{
            self.selectedIndex = 3
        } else if dayOfWeekString == "Friday"{
            self.selectedIndex = 4
        } else if dayOfWeekString == "Saturday"{
            self.selectedIndex = 5
        }
        
       
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
