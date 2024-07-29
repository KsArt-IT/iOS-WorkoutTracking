//
//  UIViewExt.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

extension UIView {

    func addBottomBorder(with color: UIColor = .ribbon, height: CGFloat = 1) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: 0, y: frame.height - height, width: frame.width, height: height)

        addSubview(separator)
    }

    // делает анимацию для кнопки при ее нажатии
    func makeSystem(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [
            .touchDown,
            .touchDragInside
        ])

        button.addTarget(self, action: #selector(handleOut), for: [
            .touchDragOutside,
            .touchDragExit,
            .touchUpInside,
            .touchUpOutside,
            .touchCancel
        ])
    }

    @objc func handleIn() {
        UIView.animate(withDuration: 0.15) { self.alpha = 0.55 }
    }

    @objc func handleOut() {
        UIView.animate(withDuration: 0.15) { self.alpha = 1 }
    }

    // MARK: - Corner Radius

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.strokeColor = UIColor.separator.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1

        layer.addSublayer(borderLayer)
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
