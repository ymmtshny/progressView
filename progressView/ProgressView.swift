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
    
    private var gapWidthRate:CGFloat    = 0.03
    private var sum: CGFloat            = 0
    private var gap:CGFloat             = 0
    private var xUnit :CGFloat          = 0
    private var currentProgress:CGFloat = 0
    private var baseView:UIView         = UIView()
    
    //MARK: classメソッド
    
    /**
     * dicinaryの値の合計値を計算して返す。
     * @param ステージの情報 [ "ステージ" : 値 ]
     * @param 現在の進行値
     * @param addSubviewするUIView
     */
    func setup(data dictinary:[String: Int], current:CGFloat, baseView:UIView) {
        
        //
        self.baseView = baseView
        
        //
        self.currentProgress = current
        
        //ステージの数
        let count = dictinary.keys.count
        
        //ステージの合計値
        let tempSum = calculateSum(dictinary)
        
        //「ステージの合計値」をもとに「ステージの間隔値」を決定する
        self.gap = calculateGapWithTotalValue(tempSum)
        
        //「ステージの合計値」+ 「ステージの間隔値」
        self.sum = tempSum + CGFloat(count - 1) * self.gap
        
        //UIViewにおけるx方向への増加率を計算
        self.xUnit = CGRectGetWidth(baseView.frame) / CGFloat(self.sum)
        
        //currentProgress以降を灰色でカバー
        self.setupCurrentProgress(current, xUnit: xUnit, baseView: baseView)
        
        //ギャップviewを追加
        self.setupGapView(dictinary, gap: gap, xUnit: xUnit, sum: self.sum, baseView: baseView)
    }
    
    
    /**
     * ステージ間隔の幅を決める値のセッターメソッド
     * @param ステージ間隔の幅を決める値(0.00 ~ 1.00)
     */
    func setGapWidthRate(rate : CGFloat) {
        if ( rate > 1 || rate < 0 ){
            print("不適")
            assert(true)
            return
        }
        
        self.gapWidthRate = rate
    }
    
    /**
    * 現在の位置に▼を追加する。
    */
    func addArrowOnCurrentProgress() {
        
        let size:CGFloat = 13
        let lable = UILabel(frame:CGRectMake(currentProgress * xUnit - size/2,
                                             -size,
                                             size,
                                             size))
        lable.text = "▼"
        lable.textColor = UIColor.redColor()
        lable.adjustsFontSizeToFitWidth = true
        self.baseView.addSubview(lable)
        
    }
    
    
    
    
    
    //MARK: privateメソッド
    
    /**
     * dicinaryの値の合計値を計算して返す。
     * @param ステージの情報 [ "ステージ" : 値 ]
     * @param 値の合計値
     */
    private func calculateSum(dictinary: [String : Int]) -> CGFloat {
        
        var tempSum: CGFloat = 0;
        for (_, value) in dictinary {
            tempSum += CGFloat(value)
        }
        
        return tempSum
    }
    
    /**
     * データの合計値に対して5%をステージの間隔とする。
     * @param ステージの合計値
     * @return ステージの間隔値
     */
    private func calculateGapWithTotalValue(sum :CGFloat) -> CGFloat {
        let tempGap = sum * gapWidthRate;
        return tempGap
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
    private func setupGapView(dictinary: [String: Int], gap: CGFloat, xUnit:CGFloat, sum:CGFloat, baseView:UIView) {
        
        let keyArray = Array(dictinary.keys).sort()
        var point: CGFloat = 0
        for index in 0...(keyArray.count - 2) {
            
            let key = keyArray[index]
            
            point = point + CGFloat(dictinary[key]!) *  xUnit
            
//            let view = UIView(frame:CGRectMake(point,
//                0,
//                gap * CGFloat( Double(100) / Double(sum)) *  xUnit,
//                CGRectGetHeight(baseView.frame)))
//            view.backgroundColor = UIColor.blackColor()
//            
//            baseView.addSubview(view)
            
            point = point +  gap  *  xUnit
            
            
            //下に丸ラベル追加
            let size = CGFloat(25)
            let label = UILabel(frame: CGRectMake(0,CGRectGetHeight(baseView.frame) + 5 ,size,size))
            label.text = "stg"
            label.font = label.font.fontWithSize(10)
            label.textAlignment = .Center
            label.center.x = point
            label.backgroundColor = UIColor.greenColor()
            label.layer.cornerRadius = size/2
            label.clipsToBounds = true
            baseView.addSubview(label)
            
            
        }
    }
    
    
    
    
}