//
//  ProgressView.swift
//  progressView
//
//  Created by Shinya Yamamoto on 2016/08/30.
//  Copyright © 2016年 Shinya Yamamoto. All rights reserved.
//

import Foundation
import UIKit
class ProgressView {
    
    
    /**
     * dicinaryの値の合計値を計算して返す。
     * @param ステージの情報 [ "ステージ" : 値 ]
     * @param 現在の進行値
     * @param addSubviewするUIView
     */
    func setup(data dictinary:[String: Int], current:CGFloat, baseView:UIView) {
        
        //ステージの数
        let count = dictinary.keys.count
        
        //ステージの合計値
        var sum = calculateSum(dictinary)
        
        //「ステージの合計値」をもとに「ステージの間隔値」を決定する
        let gap = calculateGapWithTotalValue(sum)
        
        //「ステージの合計値」+ 「ステージの間隔値」
        sum = sum + (count - 1) * Int(gap)
        
        //UIViewにおけるx方向への増加率を計算
        let xUnit = CGRectGetWidth(baseView.frame) / CGFloat(sum)
        
        //currentProgress以降を灰色でカバー
        self.setupCurrentProgress(current, xUnit: xUnit, baseView: baseView)
        
        //ギャップviewを追加
        self.setupGapView(dictinary, gap: gap, xUnit: xUnit, sum: sum, baseView: baseView)
    }
    
    /**
     * dicinaryの値の合計値を計算して返す。
     * @param ステージの情報 [ "ステージ" : 値 ]
     * @param 値の合計値
     */
    private func calculateSum(dictinary: [String : Int]) -> Int {
        
        var sum: Int = 0;
        for (_, value) in dictinary {
            sum += value
        }
        
        return sum
    }
    
    /**
     * データの合計値に対して5%をステージの間隔とする。
     * @param ステージの合計値
     * @return ステージの間隔値
     */
    private func calculateGapWithTotalValue(sum :Int) -> CGFloat {
        let gap = CGFloat(sum) * 0.05;
        return gap
    }
    
    /**
     * @param 現在のステージ値
     * @param 単位値に対するUIView上の水平方向への増加率
     * @param baseViewにaddSubviewします。
     */
    private func setupCurrentProgress(currentProgress: CGFloat, xUnit:CGFloat, baseView:UIView) {
        
        let grayView = UIView(frame:CGRectMake(currentProgress * xUnit, 0, CGRectGetWidth(baseView.frame) -  currentProgress * xUnit, CGRectGetHeight(baseView.frame)))
        grayView.backgroundColor = UIColor.grayColor()
        baseView.addSubview(grayView)
        
    }

    
    
    /**
     * @param 現在のステージ値
     * @param 単位値に対するUIView上の水平方向への増加率
     * @param baseViewにaddSubviewします。
     */
    private func setupGapView(dictinary: [String: Int], gap: CGFloat, xUnit:CGFloat, sum:Int, baseView:UIView) {
        
        let keyArray = Array(dictinary.keys).sort()
        var point: CGFloat = 0
        for index in 0...(keyArray.count - 2) {
            
            let key = keyArray[index]
            
            point = point + CGFloat(dictinary[key]!) *  xUnit
            
            let view = UIView(frame:CGRectMake(point,
                0,
                gap * CGFloat( Double(100) / Double(sum)) *  xUnit,
                CGRectGetHeight(baseView.frame)))
            view.backgroundColor = UIColor.blackColor()
            
            baseView.addSubview(view)
            
            point = point +  gap  *  xUnit
            
        }
    }
    
    
}