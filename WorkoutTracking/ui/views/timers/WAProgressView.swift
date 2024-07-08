//
//  WAProgressView.swift
//  WorkoutTracking
//
//  Created by KsArT on 01.07.2024.
//

import UIKit

final class WAProgressView: UIView {
    private let activeColor: UIColor = .active
    private let progressWidth: CGFloat = 20
    private let dotWidth: CGFloat = 8
    private let barWidth: CGFloat = 4
    private let barLenght: CGFloat = 6

    // Draw the progress circle and dot with the given percentage (0...1)
    func drawProgress(with percent: CGFloat) {
        // чтобы слои не наслаивались, удаляем предыдущие
        layer.sublayers?.removeAll()

        // основные параметры отрисовки
        let radius = (UIScreen.main.bounds.width - (15 + 40) * 2) / 2
        let bursRadius = (UIScreen.main.bounds.width - (15 + 40 + 25) * 2) / 2
        let center = CGPoint(x: radius, y: radius)
        let startAngle = -CGFloat.pi * 7 / 6
        let endAngle = CGFloat.pi * 1 / 6

        // рисуем дуги прогресса
        addArc(with: percent, center: center, radius: radius, startAngle: startAngle, endAngle: endAngle)
        // рисуем точку конечную прогресса
        addDot(with: percent, center: center, radius: radius)
        // рисуем черточки
        addBars(with: percent, center: center, radius: bursRadius, startAngle: startAngle, endAngle: endAngle)
    }

    // MARK: - Add Arcs

    // Add the circular arc to the progress view
    private func addArc(with percent: CGFloat, center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        addCircleLayer(of: circlePath.cgPath)
        addCircleLayer(of: circlePath.cgPath, with: percent, color: activeColor)
    }

    // Add a layer for the circle with the given path, percentage and color
    private func addCircleLayer(of path: CGPath, with percent: CGFloat = 1, color: UIColor = .background) {
        let circleLayer = CAShapeLayer()
        circleLayer.path = path
        circleLayer.strokeColor = color.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = progressWidth
        circleLayer.strokeEnd = percent
        circleLayer.lineCap = .round

        layer.addSublayer(circleLayer)
    }

    // MARK: - Add Dots

    // Add the dot at the end of the progress circle
    private func addDot(with percent: CGFloat, center: CGPoint, radius: CGFloat) {
        let dotAngle = CGFloat.pi * (7 - 8 * percent) / 6
        let dotPoint = CGPoint(
            x: cos(-dotAngle) * radius + center.x,
            y: sin(-dotAngle) * radius + center.y
        )

        let dotPath = UIBezierPath()
        dotPath.move(to: dotPoint)
        dotPath.addLine(to: dotPoint)

        addDotLayer(of: dotPath.cgPath, width: progressWidth, color: activeColor)
        addDotLayer(of: dotPath.cgPath, width: dotWidth)
    }

    // Add a layer for the dot with the given path, width and color
    private func addDotLayer(of path: CGPath, width: CGFloat, color: UIColor = .background) {
        let dotLayer = CAShapeLayer()
        dotLayer.path = path
        dotLayer.strokeColor = color.cgColor
        dotLayer.fillColor = color.cgColor
        dotLayer.lineCap = .round
        dotLayer.lineWidth = width

        layer.addSublayer(dotLayer)
    }

    // MARK: - Add Bars

    private func addBars(with percent: CGFloat, center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        let barsPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        let barsLayer = CAShapeLayer()
        barsLayer.path = barsPath.cgPath
        barsLayer.strokeColor = UIColor.clear.cgColor
        barsLayer.fillColor = UIColor.clear.cgColor
        barsLayer.lineWidth = barLenght

        addBarsLayer(of: barsLayer, with: percent, center: center, radius: radius)

        layer.addSublayer(barsLayer)
    }

    private func addBarsLayer(of barsLayer: CAShapeLayer, with percent: CGFloat, center: CGPoint, radius: CGFloat) {
        let barStartRadius = radius - barsLayer.lineWidth * 0.5
        let barEndRadius = barStartRadius + barsLayer.lineWidth

        var angle: CGFloat = 7 / 6
        let stepAngle: CGFloat = 1 / 6
        let percentAngle: CGFloat = (7 - 8 * percent) / 6
        for _ in 0..<9 {
            let barLayer = getBarLayer(
                center: center,
                angle: CGFloat.pi * angle,
                startRadius: barStartRadius,
                endRadius: barEndRadius,
                color: angle >= percentAngle ? activeColor : .background
            )
            barsLayer.addSublayer(barLayer)

            angle -= stepAngle
        }
    }

    private func getBarLayer(center: CGPoint, angle: CGFloat, startRadius: CGFloat, endRadius: CGFloat, color: UIColor) -> CAShapeLayer {

        let startPoint = CGPoint(
            x: cos(-angle) * startRadius + center.x,
            y: sin(-angle) * startRadius + center.y
        )
        let endPoint = CGPoint(
            x: cos(-angle) * endRadius + center.x,
            y: sin(-angle) * endRadius + center.y
        )

        let barPath = UIBezierPath()
        barPath.move(to: startPoint)
        barPath.addLine(to: endPoint)

        let barLayer = CAShapeLayer()
        barLayer.path = barPath.cgPath
        barLayer.fillColor = UIColor.clear.cgColor
        barLayer.strokeColor = color.cgColor
        barLayer.lineCap = .round
        barLayer.lineWidth = barWidth

        return barLayer
    }
}
