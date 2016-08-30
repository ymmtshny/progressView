//
//  MProgressView.swift
//  progressView
//
//  Created by Shinya Yamamoto on 2016/08/30.
//  Copyright © 2016年 Shinya Yamamoto. All rights reserved.
//

import Foundation
import UIKit

class MProgressView{
    
    private var lablePoints = [CGFloat]()
    private var currentValue:CGFloat = 0
    private var data = [CGFloat]()
    private let gap:CGFloat = 2
    private var sum:CGFloat = 0
    private var currnetLabel: UILabel?  = nil
    
    func setup(data data:[CGFloat], current:CGFloat, baseView: UIView) {
        
        self.data = data 
        let gapCount = data.count - 1
        
        
        for value in data {
            self.sum += value
        }
        
        self.sum = self.sum + gap * CGFloat(gapCount)
        
        let xUnit = CGRectGetWidth(baseView.frame) / sum
        self.currentValue = current * xUnit
        
        for index in 0...data.count - 1 {
            self.data[index] = data[index] * xUnit
        }
        
    
        var start =  0
        var colorCounter:CGFloat = 0
        for index in 0...self.data.count - 1  {
            
            for point in Int(start)...Int(self.data[index]) + start {
                
                //ステージラベル
                if point == Int(start) {
                    let size:CGFloat = 20
                    let label = UILabel(frame: CGRectMake(CGFloat(point) - size/2,
                                               CGRectGetHeight(baseView.frame) + 5,
                                               size,
                                               size))
                    label.text = "stg"
                    label.textAlignment = .Center
                    label.font = UIFont.systemFontOfSize(10)
                    label.textColor = UIColor.blackColor()
                    label.backgroundColor = UIColor.greenColor()
                    label.layer.cornerRadius = size/2
                    label.clipsToBounds = true
                    baseView.addSubview(label)
                    
                    //縦線
                    let line = UIView(frame: CGRectMake(CGRectGetMidX(label.frame),
                                             CGRectGetMaxY(label.frame) + 5,
                                             1.0,
                                             160.0))
                    line.backgroundColor = UIColor.grayColor()
                    baseView.addSubview(line)
                }
                
                let view = UIView(frame: CGRectMake(CGFloat(point), 0, xUnit, CGRectGetHeight(baseView.frame)))
                
                //現在値以降(グレー)
                if(point > Int(self.currentValue) + (index ) * Int(gap * xUnit ) ) {
                    view.backgroundColor = UIColor.grayColor()
                    
                //現在値
                } else if(point == Int(self.currentValue) + index * Int(gap * xUnit) ) {
                    
                    if currnetLabel == nil {
                        let size:CGFloat = 13
                        currnetLabel = UILabel(frame:CGRectMake(CGFloat(point)-size/2, -size, size, size))
                        currnetLabel!.text = "▼"
                        currnetLabel!.textColor = UIColor.greenColor()
                        currnetLabel!.adjustsFontSizeToFitWidth = true
                        baseView.addSubview(currnetLabel!)
                    }
                
                //すでに経過
                } else {
                
                    view.backgroundColor = UIColor(red: 48/255.0, green: (125 + colorCounter)/255.0, blue: 105/255.0, alpha: 1)
                    
                }
                
                baseView.addSubview(view)
                
                colorCounter = colorCounter + 1
            }
            
            start = start + Int(self.data[index]) +  Int(gap * xUnit)
            
        }
        
    }

}
