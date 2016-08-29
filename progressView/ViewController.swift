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
    
    //total 100 [stageNumber:%]
    let plantInfo: Dictionary = ["0": 5,
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
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //ステージ間隔を含む合計値
        let sum = calculateSum(plantInfo, gap: gap)
        
        //値１に対する増加率
        let xUnit = CGRectGetWidth(progressView.frame) / CGFloat(sum)
        
        //currentProgress以降を灰色でカバー
        self.setupCurrentProgress(self.currentProgress, xUnit: xUnit, baseView: progressView)
        
        //ギャップviewを追加
        self.setupGapView(self.plantInfo, gap: self.gap, xUnit: xUnit, sum: sum)
    }
    
    private func calculateSum(dictinary: [String: Int], gap: CGFloat)-> Int {
        let count = dictinary.keys.count
        var sum: Int = 0;
        for (_, value) in dictinary {
            sum += value
        }
        
        sum = sum + (count - 1) * Int(gap)
        
        return sum
    }
    
    private func setupCurrentProgress(currentProgress: CGFloat, xUnit:CGFloat, baseView:UIView) {
        
        let grayView = UIView(frame:CGRectMake(currentProgress * xUnit, 0, CGRectGetWidth(baseView.frame) -  currentProgress * xUnit, CGRectGetHeight(baseView.frame)))
        grayView.backgroundColor = UIColor.grayColor()
        baseView.addSubview(grayView)
        
    }
    
    private func setupGapView(dictinary: [String: Int], gap: CGFloat, xUnit:CGFloat, sum:Int) {
        
        let keyArray = Array(dictinary.keys).sort()
        var point: CGFloat = 0
        for index in 0...(keyArray.count - 2) {
            
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


