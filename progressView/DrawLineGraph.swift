//
//  DrawLineGraph.swift
//  progressView
//
//  Created by Shinya Yamamoto on 2016/08/30.
//  Copyright © 2016年 Shinya Yamamoto. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DrawLineGraph: UIView {
    
    override func drawRect(rect: CGRect) {
        
        
        // UIBezierPath のインスタンス生成
        let dx = CGFloat(35)
        let data:[CGFloat] = [30, 15, 10, 15, 28, 25]
        let rangeMax:[CGFloat] = [20, 10,  5, 10, 13, 18, 15, 20, 15, 25, 20, 15, 20]
        var rangeMin:[CGFloat] = [50, 40, 45, 40, 53, 58, 55, 60, 65, 68, 50, 60, 68]
        
        
        //MARK:適正範囲
        let rangeLine = UIBezierPath()
        
        for index in 0...rangeMax.count - 1 {
            
            if(index == 0) {
                rangeLine.moveToPoint(CGPointMake(75, rangeMax[0]))
            }
            rangeLine.addLineToPoint(CGPointMake(75 + dx * CGFloat(index), rangeMax[index]))
        }
        
        rangeMin = rangeMin.reverse()
        for index in 0...rangeMin.count - 1 {
            
            rangeLine.addLineToPoint(CGPointMake(75 + dx * CGFloat(rangeMin.count - 1 - index), rangeMin[index]))
        }
        
        UIColor.init(red: 0/255, green: 170/255, blue: 255/255, alpha: 0.2).setFill()
        UIColor.clearColor().setStroke()
        
        rangeLine.lineWidth = 1
        rangeLine.stroke()
        rangeLine.fill()
        
        //MARK:実際のデータ
        let line = UIBezierPath()
        UIColor.lightGrayColor().setFill()
        UIColor.lightGrayColor().setStroke()
        
        for index in 0...data.count - 1 {
        
            if index == 0 {
                
                line.moveToPoint(CGPointMake(75, data[0]))
            } else {
                line.addLineToPoint(CGPointMake(75 + dx * CGFloat(index), data[index]))
            }
            
            var point = CGPointMake(75 + dx * CGFloat(index), data[index])
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        line.lineWidth = 1
        line.stroke();
        
    }
    

    
}