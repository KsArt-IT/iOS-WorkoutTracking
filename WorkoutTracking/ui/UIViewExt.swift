//
//  UIViewExt.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

@objc extension UIView {

    func addBottomBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: 0, y: frame.height - height, width: frame.width, height: height)

        addSubview(separator)
    }
}
