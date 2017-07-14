//
//  QQMScrollRulerView.swift
//  YKScrollRulerSwift
//
//  Created by liupuyan on 2017/7/13.
//  Copyright © 2017年 Daniel Yao. All rights reserved.
//

import UIKit

let QQMRulerSpaceW: CGFloat = 10 // 标尺分割间距
let QQMRulerLongLine: CGFloat = 10 // 长线高度
let QQMRulerShortLine: CGFloat = 5 // 短线高度
let QQMRulerHeight: CGFloat = 39 // 标尺高度

protocol QQMScrollRulerViewDelegate: NSObjectProtocol {
    func qqmscrollRulerViewValueChange(rulerView: QQMScrollRulerView, value: CGFloat)
}

class QQMScrollRulerView: UIView {
    
    weak var delegate: QQMScrollRulerViewDelegate?
    var minValue: CGFloat = 0
    var maxValue: CGFloat = 0
    var betweenNumber: Int = 1 // 每个区块有多少个
    var stepNum: Int = 0 // 分多少个大区
    var step: CGFloat = 0 // 间隔值
    var unit: String = "" // 文字单位
    
    fileprivate var collectionCellId = "ScrollRulerViewCell"
    fileprivate var collectionHeaderCellId = "ScrollRulerViewHeaderCell"
    fileprivate var collectionFooterCellId = "ScrollRulerViewFooterCell"
    fileprivate var realValue: CGFloat = 0
    fileprivate var lastBetweenNumber: Int = 1
    
    init(frame: CGRect, minValue: CGFloat, maxValue: CGFloat, step: CGFloat, unit: String, betweenNumber: Int) {
        super.init(frame: frame)
        
        self.minValue = minValue
        self.maxValue = maxValue
        self.step = step
        self.unit = unit
        self.betweenNumber = betweenNumber
        let tstepNum = (maxValue - minValue) / step / CGFloat(betweenNumber)
        let tbetweenNumber = Int((maxValue - minValue) / step) % betweenNumber
        if tbetweenNumber == 0 {
            stepNum = Int(tstepNum)
            lastBetweenNumber = betweenNumber
        } else {
            stepNum = Int(tstepNum) + 1
            lastBetweenNumber = tbetweenNumber
        }
        setupUI()
    }
    
    func changeRulerValue(value: CGFloat) {
        var realValue: CGFloat = value
        if value <= minValue {
            realValue = minValue
        } else if value >= maxValue {
            realValue = maxValue
        }
        realValue = (realValue - minValue) / step
        setRealValueAndAnimated(realValue: realValue, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        backgroundColor = UIColor.clear
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionHeaderCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionFooterCellId)
        addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: bounds.size.height - QQMRulerHeight, width: bounds.size.width, height: QQMRulerHeight)
        
        addSubview(indicateLine)
        let indicateLineW: CGFloat = 1.5
        let indicateLineH: CGFloat = 20
        indicateLine.frame = CGRect(x: (bounds.size.width - indicateLineW) * 0.5, y: bounds.size.height - indicateLineH, width: indicateLineW, height: indicateLineH)
    }
    
    fileprivate func setRealValueAndAnimated(realValue: CGFloat, animated: Bool) {
        self.realValue = realValue
        collectionView.setContentOffset(CGPoint(x: Int(realValue) * Int(QQMRulerSpaceW), y: 0), animated: animated)
    }
    
    fileprivate lazy var indicateLine: UIView = {
        let view = UIView()
        view.backgroundColor = QQMColorcc9a00
        view.layer.cornerRadius = 0.8
        view.clipsToBounds = true
        return view
    }()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
}

extension QQMScrollRulerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stepNum + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionHeaderCellId, for: indexPath)
            var rulerView: QQMHeaderRulerView? = cell.contentView.viewWithTag(3000) as? QQMHeaderRulerView
            if rulerView == nil {
                rulerView = QQMHeaderRulerView(frame: CGRect(x: 0, y: 0, width: bounds.size.width * 0.5, height: QQMRulerHeight))
                rulerView?.tag = 3000
                rulerView?.minValue = minValue
                rulerView?.backgroundColor = UIColor.clear
                cell.contentView.addSubview(rulerView!)
            }
            rulerView?.setNeedsDisplay()
            return cell
        } else if indexPath.item == stepNum + 1 {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionFooterCellId, for: indexPath)
            var rulerView: QQMFooterRulerView? = cell.contentView.viewWithTag(3002) as? QQMFooterRulerView
            if rulerView == nil {
                rulerView = QQMFooterRulerView(frame: CGRect(x: 0, y: 0, width: bounds.size.width * 0.5, height: QQMRulerHeight))
                rulerView?.isLongLine = lastBetweenNumber == betweenNumber
                rulerView?.tag = 3002
                rulerView?.maxValue = maxValue
                rulerView?.backgroundColor = UIColor.clear
                cell.contentView.addSubview(rulerView!)
            }
            rulerView?.setNeedsDisplay()
            return cell
        } else {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath)
            var rulerView: QQMRulerView? = cell.contentView.viewWithTag(3001) as? QQMRulerView
            if rulerView == nil {
                if indexPath.item == stepNum {
                    rulerView = QQMRulerView(frame: CGRect(x: 0, y: 0, width: QQMRulerSpaceW * CGFloat(lastBetweenNumber), height: QQMRulerHeight))
                    rulerView?.betweenNumber = lastBetweenNumber
                    rulerView?.isLongLine = lastBetweenNumber == betweenNumber
                } else {
                    rulerView = QQMRulerView(frame: CGRect(x: 0, y: 0, width: QQMRulerSpaceW * CGFloat(betweenNumber), height: QQMRulerHeight))
                    rulerView?.betweenNumber = betweenNumber
                }
                rulerView?.tag = 3001
                rulerView?.step = step
                rulerView?.unit = unit
                rulerView?.backgroundColor = UIColor.clear
                cell.contentView.addSubview(rulerView!)
            }
            rulerView?.minValue = step * CGFloat(betweenNumber) * CGFloat(indexPath.item - 1)
            rulerView?.maxValue = step * CGFloat(betweenNumber) * CGFloat(indexPath.item)
            rulerView?.setNeedsDisplay()
            return cell
        }
    }
}

extension QQMScrollRulerView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / QQMRulerSpaceW
        var totalValue = value * step + minValue
        if totalValue <= minValue {
            totalValue = minValue
        } else if totalValue >= maxValue {
            totalValue = maxValue
        }
        delegate?.qqmscrollRulerViewValueChange(rulerView: self, value: totalValue)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let value = (scrollView.contentOffset.x + QQMRulerSpaceW * 0.5) / QQMRulerSpaceW
            setRealValueAndAnimated(realValue: value, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let value = (scrollView.contentOffset.x + QQMRulerSpaceW * 0.5) / QQMRulerSpaceW
        setRealValueAndAnimated(realValue: value, animated: true)
    }
}

extension QQMScrollRulerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 || indexPath.item == stepNum + 1 {
            return CGSize(width: bounds.size.width * 0.5, height: QQMRulerHeight)
        } else if indexPath.item == stepNum {
            return CGSize(width: QQMRulerSpaceW * CGFloat(lastBetweenNumber), height: QQMRulerHeight)
        }
        return CGSize(width: QQMRulerSpaceW * CGFloat(betweenNumber), height: QQMRulerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
