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
    
    @IBOutlet weak var baseView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        
        
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
        
        //相対値で決まる。
        let data:[CGFloat] = [10, 50, 15, 35, 20]
        MProgressView().setup(data:data, baseView:baseView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




