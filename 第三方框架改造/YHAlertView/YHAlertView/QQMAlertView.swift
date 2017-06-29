//
//  QQMAlertView.swift
//  YHAlertView
//
//  Created by liupuyan on 2017/6/27.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//

import UIKit

enum QQMAlertAnimationOptions {
    case none
    case zoom        // 先放大，再缩小，在还原
    case topToCenter // 从上到中间
}

enum QQMAlertActionStyle {
    case cancel
    case confirm
}

class QQMAlertView: UIView {

    // MARK: - Public Property
    public var animationOption:QQMAlertAnimationOptions = .none
    public var isCover = true {
        didSet {
            if isCover == true {
                _coverView.backgroundColor = UIColor.black
                _coverView.alpha = 0.5
            } else {
                _coverView.backgroundColor = UIColor.black
                _coverView.alpha = 1
            }
        }
    }
    
    // MARK: - Private Property
    /** 视图的宽高 */
    fileprivate let _screenWidth = QQMScreenWidth
    fileprivate let _screenHeight = QQMScreenHeight
    fileprivate let _contentWidth:CGFloat  = ScreenAdaptationSizeOfIphone6(size: 290)
    fileprivate let _contentHeight:CGFloat = 88.0
    fileprivate let _margin: CGFloat = 20
    /** 视图容器 */
    fileprivate var _contentView:UIView!
    /** 标题视图 */
    fileprivate var _labelTitle:UILabel!
    /** 内容视图 */
    fileprivate var _labelMessage:UILabel!
    fileprivate var _textMessage:ClickTextView!
    /** 遮罩层容器 */
    fileprivate var _coverView:UIView!
    /** 显示的数据 */
    fileprivate var _button1:UIButton?
    fileprivate var _button2:UIButton?
    fileprivate var _buttonAction1:OperationBlock?
    fileprivate var _buttonAction2:OperationBlock?
    
    // MARK: - init
    override init(frame: CGRect) {
        _contentView = UIView()
        _contentView.frame = CGRect(x: 0.0, y: 0.0, width: _contentWidth, height: _contentHeight)
        _contentView.center = CGPoint(x: _screenWidth * 0.5, y: _screenHeight * 0.5)
        _contentView.backgroundColor = UIColor.white
        _contentView.layer.cornerRadius = 10
        _contentView.layer.masksToBounds = true
        _contentView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        _labelTitle = UILabel()
        _labelTitle.frame = CGRect(x: _margin, y: _margin, width: _contentWidth - 2 * _margin, height: 0)
        _labelTitle.textColor = QQMColor3c4455
        _labelTitle.textAlignment = .center
        _labelTitle.font = UIFont.systemFont(ofSize: 15)
        
        _labelMessage = UILabel()
        _labelMessage.frame = CGRect(x: _margin, y: _margin, width: _contentWidth - 2 * _margin, height: 0)
        _labelMessage.textColor = QQMColor3c4455
        _labelMessage.numberOfLines = 0
        _labelMessage.font = UIFont.qqmSystemFont(ofSize: 14, weight: .thin)
        
        _textMessage = ClickTextView()
        _textMessage.frame = CGRect(x: _margin, y: _margin, width: _contentWidth - 2 * _margin, height: 0)
        _textMessage.textColor = QQMColor3c4455
        _textMessage.font = UIFont.qqmSystemFont(ofSize: 14, weight: .thin)
        _textMessage.isScrollEnabled = false
        _textMessage.showsHorizontalScrollIndicator = false
        _textMessage.showsVerticalScrollIndicator = false
        _textMessage.isEditable = false
        _textMessage.dataDetectorTypes = UIDataDetectorTypes.link
        _textMessage.textContainerInset = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: -5)
        
        _coverView = UIView()
        _coverView.frame = CGRect(x: 0, y: 0, width: _screenWidth, height: _screenHeight)
        _coverView.backgroundColor = UIColor.black
        _coverView.alpha = 0.5
        super.init(frame: frame)
    }
    
    convenience init(title: String?, messageAttributedString: NSAttributedString, buttonTitle1: String?, style1: QQMAlertActionStyle?, action1: OperationBlock?, buttonTitle2: String?, style2: QQMAlertActionStyle?, action2: OperationBlock?) {
        self.init(title: title, messageHtml: nil, message: nil, messageTextAlignment: nil, messageAttributedString: messageAttributedString, buttonTitle1: buttonTitle1, style1: style1, action1: action1, buttonTitle2: buttonTitle2, style2: style2, action2: action2)
    }
    
    convenience init(title: String?, message: String?, buttonTitle1: String?, style1: QQMAlertActionStyle?, action1: OperationBlock?, buttonTitle2: String?, style2: QQMAlertActionStyle?, action2: OperationBlock?) {
        self.init(title: title, messageHtml: nil, message: message, messageTextAlignment: nil, messageAttributedString: nil, buttonTitle1: buttonTitle1, style1: style1, action1: action1, buttonTitle2: buttonTitle2, style2: style2, action2: action2)
    }
    
    convenience init(title: String?, message: String?, messageTextAlignment: NSTextAlignment, buttonTitle1: String?, style1: QQMAlertActionStyle?, action1: OperationBlock?, buttonTitle2: String?, style2: QQMAlertActionStyle?, action2: OperationBlock?) {
        self.init(title: title, messageHtml: nil, message: message, messageTextAlignment: messageTextAlignment, messageAttributedString: nil, buttonTitle1: buttonTitle1, style1: style1, action1: action1, buttonTitle2: buttonTitle2, style2: style2, action2: action2)
    }
    
    convenience init(title: String?, messageHtml: String?, buttonTitle1: String?, style1: QQMAlertActionStyle?, action1: OperationBlock?, buttonTitle2: String?, style2: QQMAlertActionStyle?, action2: OperationBlock?) {
        self.init(title: title, messageHtml: messageHtml, message: nil, messageTextAlignment: nil, messageAttributedString: nil, buttonTitle1: buttonTitle1, style1: style1, action1: action1, buttonTitle2: buttonTitle2, style2: style2, action2: action2)
    }
    
    convenience init(title: String?, messageHtml: String?, message: String?, messageTextAlignment: NSTextAlignment?, messageAttributedString: NSAttributedString?, buttonTitle1: String?, style1: QQMAlertActionStyle?, action1: OperationBlock?, buttonTitle2: String?, style2: QQMAlertActionStyle?, action2: OperationBlock?) {
        self.init()
        
        let labelX:CGFloat = _margin
        let labelY:CGFloat = _margin
        let labelW:CGFloat = _contentWidth - 2 * labelX
        if let title = title {
            _labelTitle.text = title
            _labelTitle.sizeToFit()
            
            let size = _labelTitle.frame.size
            _labelTitle.frame = CGRect(x: labelX, y: labelY, width: labelW, height: size.height)
        }
        
        if let message = messageHtml {
            var attr = NSMutableAttributedString()
            do {
                attr = try NSMutableAttributedString(data: message.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            } catch {}
            _labelMessage.attributedText = attr
            _labelMessage.sizeToFit()
            _labelMessage.isHidden = false
            _textMessage.isHidden = true
        } else if let messageAttributedString = messageAttributedString {
            _textMessage.attributedText = messageAttributedString
            _textMessage.sizeToFit()
            _labelMessage.isHidden = true
            _textMessage.isHidden = false
        } else if let message = message {
            if (messageTextAlignment != nil) {
                let style = NSMutableParagraphStyle()
                let messageText = NSMutableAttributedString.init(string: message)
                style.lineSpacing = 8 // 行距
                style.alignment = messageTextAlignment!
                
                messageText.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: messageText.length))
                _labelMessage.attributedText = messageText
                _labelMessage.sizeToFit()
                _labelMessage.isHidden = false
                _textMessage.isHidden = true
            } else {
                // 计算行高
                let messageStr: NSString = message as NSString
                let dict = [NSKernAttributeName: 0.8] as [String : Any]
                let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
                let size = messageStr.boundingRect(with: CGSize.init(width: _contentWidth - 4 * _margin, height: CGFloat(MAXFLOAT)), options: options, attributes: dict, context: nil)
                
                let style = NSMutableParagraphStyle()
                let messageText = NSMutableAttributedString.init(string: message)
                // 字间距
                messageText.addAttribute(NSKernAttributeName, value: 0.8, range: NSRange.init(location: 0, length: messageText.length))
                if size.height > 15 {
                    style.firstLineHeadIndent = 30 // 缩进
                    style.lineSpacing = 8 // 行距
                    style.alignment = .left
                } else {
                    style.firstLineHeadIndent = 0 // 缩进
                    style.lineSpacing = 0 // 行距
                    style.alignment = .center
                }
                
                messageText.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: messageText.length))
                _labelMessage.attributedText = messageText
                _labelMessage.sizeToFit()
                _labelMessage.isHidden = false
                _textMessage.isHidden = true
            }
        }
        
        var sizeMessage: CGSize = CGSize.zero
        if _labelMessage.isHidden == false {
            sizeMessage = _labelMessage.frame.size
        } else if _textMessage.isHidden == false {
            sizeMessage = _textMessage.frame.size
        }
        if (title != nil) {
            _labelMessage.frame = CGRect(x: labelX, y: _labelTitle.frame.maxY + _margin, width: labelW, height: sizeMessage.height)
            _textMessage.frame = CGRect(x: labelX, y: _labelTitle.frame.maxY + _margin, width: labelW, height: sizeMessage.height)
        } else {
            _labelMessage.frame = CGRect(x: labelX, y: _labelTitle.frame.maxY, width: labelW, height: sizeMessage.height)
            _textMessage.frame = CGRect(x: labelX, y: _labelTitle.frame.maxY, width: labelW, height: sizeMessage.height)
        }
        if let buttonTitle = buttonTitle1, let style = style1 {
            _buttonAction1 = action1
            _button1 = _button(style: style, title: buttonTitle, target: self, action: #selector(_button1Click))
            _button1?.setTitle(buttonTitle, for: .normal)
        }
        
        if let buttonTitle = buttonTitle2, let style = style2 {
            _buttonAction2 = action2
            _button2 = _button(style: style, title: buttonTitle, target: self, action: #selector(_button2Click))
            _button2?.setTitle(buttonTitle, for: .normal)
        }
        
        _setupUI()
        _setupButton()
    }
    
    func _button1Click() {
        if (_buttonAction1 != nil) {
            _buttonAction1!()
        }
        
        _remove()
    }
    
    func _button2Click() {
        if (_buttonAction2 != nil) {
            _buttonAction2!()
        }
        
        _remove()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QQMAlertView {
    fileprivate func _setupUI() {
        frame = CGRect(x: 0, y: 0, width: _screenWidth, height: _screenHeight)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = UIColor.clear
        addSubview(_coverView)
        addSubview(_contentView)
        _contentView.addSubview(_labelTitle)
        _contentView.addSubview(_labelMessage)
        _contentView.addSubview(_textMessage)
    }
    
    fileprivate func _button(style: QQMAlertActionStyle, title: String, target: Any, action: Selector) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.qqmSystemFont(ofSize: 15, weight: .regular)
        switch style {
        case .confirm:
            button.setBackgroundColor(QQMGlobalColor, for: .normal)
        case .cancel:
            button.setBackgroundColor(QQMColorcccccc, for: .normal)
        }
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    fileprivate func _setupButton() {
        var buttons: [UIButton] = []
        if let button = _button1 {
            buttons.append(button)
        }
        if let button = _button2 {
            buttons.append(button)
        }
        var buttonY =  _margin
        if _labelMessage.isHidden == false {
            buttonY = buttonY + _labelMessage.frame.maxY
        } else if _textMessage.isHidden == false {
            buttonY = buttonY + _textMessage.frame.maxY
        }
        if buttons.count == 1 {
            if (_button1 != nil) {
                _button1?.frame = CGRect(x: _margin, y: buttonY, width: _contentWidth - 2 * _margin, height: _contentHeight * 0.5)
                _contentView.addSubview(_button1!)
            }
        } else if buttons.count == 2 {
            let buttonWidth: CGFloat = (_contentWidth - _margin * 3) / 2
            if (_button1 != nil) {
                _button1?.frame = CGRect(x: _margin, y: buttonY, width: buttonWidth, height: _contentHeight * 0.5)
                _contentView.addSubview(_button1!)
            }
            if (_button2 != nil) {
                _button2?.frame = CGRect(x: _margin * 2 + buttonWidth, y: buttonY, width: buttonWidth, height: _contentHeight * 0.5)
                _contentView.addSubview(_button2!)
            }
        }
        
        let height = _contentHeight * 0.5 + buttonY + _margin
        _contentView.frame = CGRect(x: 0, y: 0, width: _contentWidth, height: height)
        _contentView.center = self.center
    }
    
    fileprivate func _remove() {
        switch animationOption {
        case .none:
            UIView.animate(withDuration: 0.3, animations: {
                [unowned self] in
                self._contentView.alpha = 0.0
                }, completion: { [unowned self] (finished:Bool) in
                self.removeFromSuperview()
            })
            break
        case .zoom:
            UIView.animate(withDuration: 0.3, animations: {
                [unowned self] in
                self._contentView.alpha = 0.0
                }, completion: { [unowned self] (finished:Bool) in
                    self.removeFromSuperview()
            })
            break
        case .topToCenter:
            let endPoint = CGPoint(x: center.x, y: frame.height+_contentView.frame.height)
            UIView.animate(withDuration: 0.3, animations: {
                self._contentView.layer.position = endPoint
            }, completion: {[unowned self] (finished:Bool)in
                self.removeFromSuperview()
            })
            break
        }
    }
}

extension QQMAlertView {
    func clickUnderlineText(underlineTextRange: NSRange, action: OperationParamBlock?) {
        _textMessage.setUnderlineText(underlineTextRange: underlineTextRange, coverColor: nil, block: action)
    }
    
    func show() {
        let view: UIView = QQMKeyWindow!!
        view.addSubview(self)
        
        switch animationOption {
        case .none:
            _contentView.alpha = 0.0
            UIView.animate(withDuration: 0.34, animations: { [unowned self] in
                self._contentView.alpha = 1.0
            })
            break
        case .zoom:
            self._contentView.layer.setValue(0, forKeyPath: "transform.scale")
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                [unowned self] in
                self._contentView.layer.setValue(1.0, forKeyPath: "transform.scale")
                }, completion: { _ in
                    
            })
            break
        case .topToCenter:
            let startPoint = CGPoint(x: center.x, y: _contentView.frame.height)
            _contentView.layer.position = startPoint
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: { [unowned self] in
                self._contentView.layer.position = self.center
                }, completion: { _ in
                    
            })
            break
            
        }
    }
}
