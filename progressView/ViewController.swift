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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var data:[CGFloat] = [10, 20, 15, 35, 20]
        let gapCount = data.count - 1
        let gap:CGFloat = 1
        
        var sum:CGFloat = 0
        for value in data {
            sum += value
        }
        
        sum = sum +  gap * CGFloat(gapCount)
        
        for index in 0...data.count - 1 {
            data[index] = data[index] * 100 / sum
        }
        
        print(data)
        
        var beginValue = CGFloat(0)
        for value in data {
            
            let frame = CGRectMake(CGRectGetWidth(self.view.frame) * (beginValue) / 100 ,
                                   50,
                                   CGRectGetWidth(self.view.frame) * value / 100,
                                   8)
            
            let test = progressView(beginValue:beginValue ,
                                    endValue:(beginValue + value),
                                    frame :frame)
            
            beginValue = beginValue + value + gap
            
            self.view.addSubview(test)
            
            print(frame)
        }
        
        
        
    }
    
    /**
     *  @prams スタート値 0 ~ 100
     *  @prams エンド値 0 ~ 100
     *  @prams viewのフレーム
     */
    func progressView(beginValue beginValue: CGFloat, endValue:CGFloat, frame: CGRect) -> UIView {
     
        let strColor = UIColor.colorWithRedValue(redValue: 48, greenValue: 150 + beginValue, blueValue: 105, alpha: 1)
        let endColor = UIColor.colorWithRedValue(redValue: 48, greenValue: 150 + endValue, blueValue: 105, alpha: 1)
        
        let view: UIView = UIView(frame:frame)
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [strColor.CGColor, endColor.CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        return view
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let dictinary = ["0":5,
                         "1":10,
                         "2":30,
                         "3":50,
                         "4":20]
        
        let current = CGFloat(70)
        
        let test = ProgressView()
        test.setup(data:dictinary,current: current,baseView:progressView)
        test.addArrowOnCurrentProgress()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension UIColor {
    static func colorWithRedValue(redValue redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}


