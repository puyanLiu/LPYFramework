//
//  ViewController.swift
//  Toast-Swift
//
//  Copyright (c) 2015 Charles Scalesse.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be included
//  in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

class ViewController: UITableViewController {

    fileprivate let switchCellId = "ToastSwitchCellId"
    fileprivate let demoCellId = "ToastDemoCellId"
    
    fileprivate var showingActivity = false
    
    // MARK: - Constructors
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.title = "Toast-Swift"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not used")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: demoCellId)
    }
    
    // MARK: - Events
    
    func handleTapToDismissToggled() {
        ToastManager.shared.tapToDismissEnabled = !ToastManager.shared.tapToDismissEnabled
    }
    
    func handleQueueToggled() {
        ToastManager.shared.queueEnabled = !ToastManager.shared.queueEnabled
    }
}

// MARK: - UITableViewDelegate & DataSource Methods

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 9
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "SETTINGS"
        } else {
            return "DEMOS"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0 {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: switchCellId)
            
            if (indexPath as NSIndexPath).row == 0 {
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: switchCellId)
                    let tapToDismissSwitch = UISwitch()
                    tapToDismissSwitch.onTintColor = UIColor.blue
                    tapToDismissSwitch.isOn = ToastManager.shared.tapToDismissEnabled
                    tapToDismissSwitch.addTarget(self, action: #selector(ViewController.handleTapToDismissToggled), for: .valueChanged)
                    cell?.accessoryView = tapToDismissSwitch
                    cell?.selectionStyle = .none
                    cell?.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
                }
                cell?.textLabel?.text = "Tap to dismiss"
            } else {
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: switchCellId)
                    let queueSwitch = UISwitch()
                    queueSwitch.onTintColor = UIColor.blue
                    queueSwitch.isOn = ToastManager.shared.queueEnabled
                    queueSwitch.addTarget(self, action: #selector(ViewController.handleQueueToggled), for: .valueChanged)
                    cell?.accessoryView = queueSwitch
                    cell?.selectionStyle = .none
                    cell?.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
                }
                cell?.textLabel?.text = "Queue toast"
            }
            
            return cell!
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: demoCellId, for: indexPath)
            cell.textLabel?.numberOfLines = 2
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
            cell.accessoryType = .disclosureIndicator
            
            if (indexPath as NSIndexPath).row == 0 {
                cell.textLabel?.text = "Make toast"
            } else if (indexPath as NSIndexPath).row == 1 {
                cell.textLabel?.text = "Make toast on top for 3 seconds"
            } else if (indexPath as NSIndexPath).row == 2 {
                cell.textLabel?.text = "Make toast with a title"
            } else if (indexPath as NSIndexPath).row == 3 {
                cell.textLabel?.text = "Make toast with an image"
            } else if (indexPath as NSIndexPath).row == 4 {
                cell.textLabel?.text = "Make toast with a title, image, and completion block"
            } else if (indexPath as NSIndexPath).row == 5 {
                cell.textLabel?.text = "Make toast with a custom style"
            } else if (indexPath as NSIndexPath).row == 6 {
                cell.textLabel?.text = "Show a custom view as toast"
            } else if (indexPath as NSIndexPath).row == 7 {
                cell.textLabel?.text = "Show an image as toast at point\n(110, 110)"
            } else if (indexPath as NSIndexPath).row == 8 {
                cell.textLabel?.text = (self.showingActivity) ? "Hide toast activity" : "Show toast activity"
            }
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0 {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath as NSIndexPath).row == 0 {
            
            // Make Toast
//            self.navigationController?.view.makeToast("This is a piece of toast")
        
            
            
            // 圆环直径
            let circleSize: CGFloat = 40
            // 缺口角度
            let gapAngle: CGFloat = 20
            
            let wrapperView = UIView()
            let screenSize = UIScreen.main.bounds.size
            let style = ToastManager.shared.style
            wrapperView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.8)
            wrapperView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
            wrapperView.layer.cornerRadius = 10
            
            // 中间部分
            let customRect = CGRect(x: 0, y: style.horizontalPadding * 2, width: circleSize, height: circleSize)
            let customView = UIView(frame: customRect)
            wrapperView.addSubview(customView)
            
            let squareView = UIView(frame: CGRect(x: (circleSize - circleSize * 0.3) * 0.5, y: (circleSize - circleSize * 0.3) * 0.5, width: circleSize * 0.3, height: circleSize * 0.3))
            squareView.layer.borderColor = UIColor.white.cgColor
            squareView.layer.borderWidth = 1
            squareView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
            customView.addSubview(squareView)
            
            // 转环
            let animationLayer = CAShapeLayer()
            animationLayer.bounds = customView.bounds
            animationLayer.position = CGPoint(x: customView.bounds.midX, y: customView.bounds.midY)
            animationLayer.strokeColor = UIColor.white.cgColor
            animationLayer.fillColor = UIColor.clear.cgColor
            animationLayer.lineJoin = "round"
            animationLayer.lineCap = "round"
            animationLayer.lineWidth = 1
            animationLayer.strokeStart = 0
            animationLayer.strokeEnd = 1
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: circleSize * 0.5, y: circleSize * 0.5), radius: circleSize * 0.5 - 2, startAngle: 0, endAngle: CGFloat(Double.pi * 2) - CGFloat(Double.pi) * gapAngle / 180, clockwise: false)
            animationLayer.path = path
            customView.layer.addSublayer(animationLayer)
            
            // 动画
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.fromValue = 0
            animation.toValue = Double.pi * 2
            animation.duration = 1
            animation.isCumulative = true
            animation.repeatCount = Float.infinity
            animationLayer.add(animation, forKey: "")
            
            // 提示语
            let messageLabel = UILabel()
            messageLabel.text = "正在拼命加载中"
            messageLabel.numberOfLines = style.messageNumberOfLines
            messageLabel.font = UIFont.systemFont(ofSize: 15)
            messageLabel.textAlignment = .center
            messageLabel.lineBreakMode = .byTruncatingTail;
            messageLabel.textColor = style.messageColor
            wrapperView.addSubview(messageLabel)
        
            // 计算messageLabel的frame
            let maxMessageSize = CGSize(width: screenSize.width * style.maxWidthPercentage, height: screenSize.height * style.maxHeightPercentage)
            let messageSize = messageLabel.sizeThatFits(maxMessageSize)
            let actualWidth = min(messageSize.width, maxMessageSize.width)
            let actualHeight = min(messageSize.height, maxMessageSize.height)
            let messageRect = CGRect(x: style.horizontalPadding * 2, y: style.verticalPadding + customRect.maxY, width: actualWidth, height: actualHeight)
            messageLabel.frame = messageRect
            
            // 计算wrapperView的frame
            let longerWidth = messageRect.size.width
            let longerX = messageRect.origin.x
            let wrapperWidth = max(style.horizontalPadding * 2.0, (longerX + longerWidth + style.horizontalPadding * 2))
            let wrapperHeight = max((messageRect.origin.y + messageRect.size.height + style.verticalPadding * 2), style.verticalPadding * 2.0)
            wrapperView.frame = CGRect(x: 0.0, y: 0.0, width: wrapperWidth, height: wrapperHeight)
            
            // 计算customView的position
            var customCenter = customView.center
            customCenter.x = wrapperView.center.x
            customView.center = customCenter
            
            
            self.navigationController?.view.showToast(wrapperView)
//            
//            
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(5000)) {
//                self.navigationController?.view.hideToast()
//            }
            
        } else if (indexPath as NSIndexPath).row == 1 {
            
            // Make toast with a duration and position
//            self.navigationController?.view.makeToast("This is a piece of toast on top for 3 seconds", duration: 3.0, position: .top)
            
            
            self.navigationController?.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(5000)) {
                self.navigationController?.view.hideToastActivity()
            }
            
        } else if (indexPath as NSIndexPath).row == 2 {
            
            // Make toast with a title
            self.navigationController?.view.makeToast("This is a piece of toast with a title", duration: 2.0, position: .top, title: "Toast Title", image: nil, style: nil, completion: nil)
            
        } else if (indexPath as NSIndexPath).row == 3 {
            
            // Make toast with an image
            self.navigationController?.view.makeToast("This is a piece of toast with an image", duration: 2.0, position: .center, title: nil, image: UIImage(named: "toast.png"), style: nil, completion: nil)
            
        } else if (indexPath as NSIndexPath).row == 4 {
            
            // Make toast with an image, title, and completion closure
            self.navigationController?.view.makeToast("This is a piece of toast with a title, image, and completion closure", duration: 2.0, position: .bottom, title: "Toast Title", image: UIImage(named: "toast.png"), style:nil) { (didTap: Bool) -> Void in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
        
        } else if (indexPath as NSIndexPath).row == 5 {
            
            var style = ToastStyle()
            style.messageFont = UIFont(name: "Zapfino", size: 14.0)!
            style.messageColor = UIColor.red
            style.messageAlignment = .center
            style.backgroundColor = UIColor.yellow
            
            self.navigationController?.view.makeToast("This is a piece of toast with a custom style", duration: 3.0, position: .bottom, style: style)
            
        } else if (indexPath as NSIndexPath).row == 6 {
            
            // Show a custom view as toast
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 80.0, height: 400.0))
            customView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
            customView.backgroundColor = UIColor.blue
            
            self.navigationController?.view.showToast(customView, duration: 2.0, position: .center, completion:nil)
            
            
        } else if (indexPath as NSIndexPath).row == 7 {
            
            // Show an imageView as toast, on center at point (110,110)
            let toastView = UIImageView(image: UIImage(named: "toast.png"))
            
            self.navigationController?.view.showToast(toastView, duration: 2.0, position: CGPoint(x: 110.0, y: 110.0), completion: nil)
            
        } else if (indexPath as NSIndexPath).row == 8 {
            
            // Make toast activity
            if !self.showingActivity {
                self.navigationController?.view.makeToastActivity(.center)
            } else {
                self.navigationController?.view.hideToastActivity()
            }
            
            self.showingActivity = !self.showingActivity
            
            tableView.reloadData()
        }
    }
}
