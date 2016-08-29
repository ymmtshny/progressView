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


