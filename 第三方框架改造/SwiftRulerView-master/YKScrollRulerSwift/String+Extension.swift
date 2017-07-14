//
//  String+Extension.swift
//  QQMProjectSwift
//
//  Created by liupuyan on 2017/5/12.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import Foundation

extension String {
    
    // String使用下标读取字符串
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return self[startIndex..<endIndex]
        }
    }
    
    func removeCharWithString(chars: NSArray) -> String {
        let str = self
        chars.enumerateObjects({ (obj, idx, stop) in
        
        })
        return str
    }
}

// MARK: - 添加Range->NSRange，NSRange->Range
extension String {
    
    
    /// Range->NSRange
    ///
    /// - Parameter range: <#range description#>
    /// - Returns: <#return value description#>
    func nsRnage(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange.init(location: utf16.distance(from: utf16.startIndex, to: from), length: utf16.distance(from: from, to: to))
    }
    
    /// NSRange->Range
    ///
    /// - Parameter nsRange: <#nsRange description#>
    /// - Returns: <#return value description#>
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from..<to
    }
}
