//
//  ViewController.swift
//  customProgressViewSample
//
//  Created by Shinya Yamamoto on 2016/08/08.
//  Copyright © 2016年 Shinya Yamamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIView!
    let stage1 = ["2016-04-01" , "2016-04-30"]
    let stage2 = ["2016-05-01" , "2016-05-15"]
    let stage3 = ["2016-05-16" , "2016-06-30"]
    let stage4 = ["2016-08-01" , "2016-08-30"]
    
    //total 100 [stageNumber:%]
    let plantInfo: Dictionary = ["0":5,
                                 "1": 35,
                                 "2": 25,
                                 "3": 25,
                                 "4": 10]
    // %
    let currentProgress: CGFloat = 66
    
    let gap : CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // "2015-10-06T15:42:34Z"
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print ( dateFormatter.dateFromString( stage1[0]) )
        let date1 = dateFormatter.dateFromString( stage1[0])
        //---------------------------------------------------
        
        //       let view = UIView(frame: CGRectMake(0,0,w,h))
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let count = plantInfo.keys.count
        var sum = calculateSum(plantInfo)
        sum = sum + (count - 1) * Int(gap)
        let xUnit = CGRectGetWidth(progressView.frame) / CGFloat(sum)
        
        
        //currentProgress以降を灰色でカバー
        let grayView = UIView(frame:CGRectMake(currentProgress * xUnit, 0, CGRectGetWidth(progressView.frame) -  currentProgress * xUnit, CGRectGetHeight(progressView.frame)))
        grayView.backgroundColor = UIColor.grayColor()
        progressView.addSubview(grayView)
        
        
        //ギャップviewを追加
        let keyArray = Array(plantInfo.keys).sort()
        var point: CGFloat = 0
        for index in 0...(count - 2) {
            
            let key = keyArray[index]
            
            point = point + CGFloat(plantInfo[key]!) *  xUnit
            
            let view = UIView(frame:CGRectMake(point,
                0,
                gap * CGFloat( Double(100) / Double(sum)) *  xUnit,
                CGRectGetHeight(progressView.frame)))
            view.backgroundColor = UIColor.blackColor()
            
            progressView.addSubview(view)
            
            point = point +  gap  *  xUnit
            
        }
    }
    
    private func calculateSum(dictinary: [String: Int])-> Int {
        
        var sum: Int = 0;
        for (_, value) in dictinary {
            sum += value
        }
        
        return sum
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension NSDate {
    func yearsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    func daysFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
    func hoursFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
    }
    func minutesFrom(date: NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
    func secondsFrom(date: NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
    }
    func offsetFrom(date: NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
}
