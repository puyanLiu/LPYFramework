//
//  QQMRefreshHeaderAnimator.swift
//  ESPullToRefreshExample
//
//  Created by liupuyan on 2017/6/7.
//  Copyright © 2017年 egg swift. All rights reserved.
//

import UIKit

let QQMScreenBounds = UIScreen.main.bounds
let QQMScreenWidth = QQMScreenBounds.size.width
let QQMScreenHeight = QQMScreenBounds.size.height


// 圆环直径
let circleSize: CGFloat = 26
// 缺口角度
let gapAngle: CGFloat = 20
let imageH: CGFloat = 20
let imageSizeScale: CGFloat = 135 / 15
let refreshMargin: CGFloat = 10

class QQMRefreshHeaderAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol, ESRefreshImpactProtocol {

    open var pullToRefreshDescription = NSLocalizedString("下拉即可刷新", comment: "") {
        didSet {
            if pullToRefreshDescription != oldValue {
                titleLabel.text = pullToRefreshDescription;
            }
        }
    }
    open var releaseToRefreshDescription = NSLocalizedString("松开立即刷新", comment: "")
    open var loadingDescription = NSLocalizedString("正在刷新数据...", comment: "")
    
    open var view: UIView { return self }
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var trigger: CGFloat = 80.0
    open var executeIncremental: CGFloat = 80.0
    open var state: ESRefreshViewState = .pullToRefresh
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.blue
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let customView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let squareView: UIView = {
        let squareView = UIView()
        squareView.layer.borderColor = UIColor.red.cgColor
        squareView.layer.borderWidth = 1
        return squareView
    }()
    
    fileprivate let animationLayer: CAShapeLayer = {
        // 转环
        let animationLayer = CAShapeLayer()
        animationLayer.strokeColor = UIColor.red.cgColor
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.lineJoin = "round"
        animationLayer.lineCap = "round"
        animationLayer.lineWidth = 1
        animationLayer.strokeStart = 0
        animationLayer.strokeEnd = 1
        return animationLayer
    }()
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "bg_pulltorefresh"))
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.gray
        
        self.addSubview(imageView)
        
        titleLabel.text = pullToRefreshDescription
        self.addSubview(titleLabel)
        
        customView.frame = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
        
        squareView.frame = CGRect(x: (circleSize - circleSize * 0.3) * 0.5, y: (circleSize - circleSize * 0.3) * 0.5, width: circleSize * 0.3, height: circleSize * 0.3)
        squareView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
        customView.addSubview(squareView)
        
        animationLayer.bounds = customView.bounds
        animationLayer.position = CGPoint(x: customView.bounds.midX, y: customView.bounds.midY)
        updateCirclePath(value: 1)
        customView.layer.addSublayer(animationLayer)
        self.addSubview(customView)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        UIView.performWithoutAnimation {
            let startY: CGFloat = (executeIncremental - imageH - circleSize - refreshMargin) * 0.5
            imageView.frame = CGRect(x: 0, y: startY, width: imageH * imageSizeScale, height: imageH)
            imageView.centerX_ = view.centerX_
            customView.y_ = imageView.frame.maxY + refreshMargin
            customView.x_ = view.centerX_ - circleSize - 30
            titleLabel.sizeToFit()
            titleLabel.centerY_ = customView.centerY_
            titleLabel.x_ = customView.frame.maxX + refreshMargin
        }
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1
        animation.isCumulative = true
        animation.repeatCount = Float.infinity
        animationLayer.add(animation, forKey: "")
    }
    
    func endAnimation() {
        animationLayer.removeAllAnimations()
    }
    
    open func refreshAnimationBegin(view: ESRefreshComponent) {
        print("begin---------------2")
        startAnimation()
    }
    
    open func refreshAnimationEnd(view: ESRefreshComponent) {
        print("end---------------4")
        endAnimation()
    }
    
    open func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
            case .releaseToRefresh:
                titleLabel.text = releaseToRefreshDescription
                self.setNeedsLayout()
                print("releaseToRefreshDescription---------------1")
                break
            case .refreshing, .autoRefreshing:
                titleLabel.text = loadingDescription
                self.setNeedsLayout()
                print("loadingDescription---------------3")
                break
            case .pullToRefresh:
                titleLabel.text = pullToRefreshDescription
                self.setNeedsLayout()
                print("pullToRefreshDescription---------------5")
                break
            default:
                break
        }
    }
    
    open func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        print("什么时候呢---\(progress)")
        
        updateCirclePath(value: progress)
    }
    
    func updateCirclePath(value: CGFloat) {
        let startAngle: CGFloat = 90
        let endAngle: CGFloat = value * (360 - gapAngle + startAngle)
        if value > 1 {
            return
        }
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: circleSize * 0.5, y: circleSize * 0.5), radius: circleSize * 0.5 - 2, startAngle: CGFloat(Double.pi) * startAngle / 180, endAngle: CGFloat(Double.pi) * endAngle / 180, clockwise: false)
        animationLayer.path = path
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
