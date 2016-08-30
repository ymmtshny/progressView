//
//  DrawLineGraph.swift
//  progressView
//
//  Created by Shinya Yamamoto on 2016/08/30.
//  Copyright © 2016年 Shinya Yamamoto. All rights reserved.
//

import Foundation
import UIKit

class DrawLineGraph: UIView {
    
    override func drawRect(rect: CGRect) {
        
        // UIBezierPath のインスタンス生成
        let line = UIBezierPath();
        
        
        line.moveToPoint(CGPointMake(40, 30));
        line.addLineToPoint(CGPointMake(80,15));
        line.addLineToPoint(CGPointMake(120,10));
        line.addLineToPoint(CGPointMake(160,15));
        line.addLineToPoint(CGPointMake(200,20));
        line.addLineToPoint(CGPointMake(240,22));
        
        
        // 色の設定
        UIColor.redColor().setStroke()
        
        // ライン幅
        line.lineWidth = 1
        
        // 描画
        line.stroke();
        
    }
    
}