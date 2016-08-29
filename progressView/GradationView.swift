//
//  GradiantView.swift
//  customProgressViewSample
//
//  Created by Shinya Yamamoto on 2016/08/29.
//  Copyright © 2016年 Shinya Yamamoto. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradationView: UIView {
    
    @IBInspectable var gradationStartColor : UIColor = UIColor.whiteColor()
    @IBInspectable var gradationEndColor : UIColor = UIColor.blackColor()
    @IBInspectable var gradationXPosition : CGFloat = 0.5
    @IBInspectable var gradationYPosition : CGFloat = 0.5
    @IBInspectable var circleSize : CGFloat = 1.0
    
    override func drawRect(rect: CGRect) {
        
        var startRed: CGFloat   = 0
        var startGreen: CGFloat = 0
        var startBlue: CGFloat  = 0
        var startAlpha: CGFloat = 0
        self.gradationStartColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
        
        var endRed: CGFloat   = 0
        var endGreen: CGFloat = 0
        var endBlue: CGFloat  = 0
        var endAlpha: CGFloat = 0
        self.gradationEndColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        CGContextAddEllipseInRect(context, self.frame)
        
        let colorSpaceRef:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let components:[CGFloat] = [
            startRed, startGreen, startBlue, startAlpha,
            endRed, endGreen, endBlue, endAlpha,
            ]
        
        let locations:[CGFloat] = [ 0.0, 1.0 ]
        let locationCount = Int(locations.count)
        let gradientRef: CGGradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, locationCount)!
        
        let frame:CGRect = self.bounds
        
        var startCenter: CGPoint = frame.origin
        startCenter.x += frame.size.width  * self.gradationXPosition
        startCenter.y += frame.size.height * self.gradationYPosition
        let endCenter = startCenter
        
        let startRadius: CGFloat = 0.0
        let endRadius  : CGFloat = CGRectGetWidth(self.bounds) * self.circleSize
        
        let options: CGGradientDrawingOptions = [.DrawsAfterEndLocation]

        
        CGContextDrawRadialGradient(context, gradientRef, startCenter, startRadius, endCenter, endRadius, options)
        
        CGContextRestoreGState(context)
    }
}