//
//  Fonts.swift
//  CarouselExample
//
//  Created by 정혜영 on 2021/10/01.
//

import UIKit

struct Fonts {
    
    //MARK: Font name prefixes
    static private let notoSans = "NotoSansCJKkr"
    
    
    //MARK: Font Types
    enum FontTypes: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
    }
    
    static func text9(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 9)
    }
    
    static func text10(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 10)
    }
    
    static func text11(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 11)
    }
    
    static func text12(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 12)
    }
    
    static func text14(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 14)
    }
    
    static func text16(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 16)
    }
    
    static func text18(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 18)
    }
    
    static func text19(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 19)
    }
    
    static func text20(fontType: FontTypes = .regular) -> UIFont? {
        return font(prefix: notoSans, type: fontType.rawValue, size: 20)
    }
    
    //MARK: Private Methods
    static private func font(prefix: String, type: String, size: CGFloat) -> UIFont? {
        let name = "\(prefix)-\(type)"
        
//        for family in UIFont.familyNames {
//            debugPrint("family:", family)
//            for font in UIFont.fontNames(forFamilyName: family) {
//                debugPrint("font:", font)
//            }
//        }
        
        return UIFont(name: name, size: size)
    }
}

