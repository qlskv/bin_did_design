//
//  CustomTabbar.swift
//  ezHION
//
//  Created by bin on 2021/10/26.
//
import UIKit
import Foundation
//2021-10-26, bin tabbar높이 조절 추가
let tabBarHeight: CGFloat = 80.0

@IBDesignable
class CustomTabbar: UITabBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = tabBarHeight
        return size
    }
    

}
