//
//  ChartView.swift
//  WorkoutTracking
//
//  Created by KsArT on 23.07.2024.
//

import UIKit

final class ChartView: BaseInfoView {

    private let yAxis: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    private let xAxis: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()

    // MARK: - Configure View
    func configure(with data: [ChartsView.Data], of topChartOffset: Int) {
        layoutIfNeeded()
        drawDashLines()
        drawChart(with: data, of: topChartOffset)
    }
}

// MARK: - Setup View
extension ChartView {

    override func setupViews() {
        super.setupViews()

        addSubview(yAxis)
        addSubview(xAxis)
    }

    override func constraintViews() {
        super.constraintViews()

        yAxis.translatesAutoresizingMaskIntoConstraints = false
        xAxis.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            yAxis.leadingAnchor.constraint(equalTo: leadingAnchor),
            yAxis.topAnchor.constraint(equalTo: topAnchor),
            yAxis.bottomAnchor.constraint(equalTo: bottomAnchor),
            yAxis.widthAnchor.constraint(equalToConstant: 1),

            xAxis.leadingAnchor.constraint(equalTo: leadingAnchor),
            xAxis.trailingAnchor.constraint(equalTo: trailingAnchor),
            xAxis.bottomAnchor.constraint(equalTo: bottomAnchor),
            xAxis.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .clear
    }
}

private extension ChartView {

    func drawDashLines(_ count: Int = 9) {
        let yDelta = bounds.height / CGFloat(count)
        (0..<count).forEach { i in
            let yPos = yDelta * CGFloat(i)
            drawDashLine(at: yPos)
        }

    }

    func drawDashLine(at yPos: CGFloat) {
        let startPoint = CGPoint(x: 0, y: yPos)
        let endPoint = CGPoint(x: bounds.width, y: yPos)

        let dashPath = CGMutablePath()
        dashPath.addLines(between: [startPoint, endPoint])

        let dashLayer = CAShapeLayer()
        dashLayer.path = dashPath
        dashLayer.strokeColor = UIColor.separator.cgColor
        dashLayer.lineWidth = 1
        dashLayer.lineDashPattern = [6, 3]

        layer.addSublayer(dashLayer)
    }

    func drawChart(with data: [ChartsView.Data], of topChartOffset: Int) {
        guard let maxValue = data.max(by: { $0.value < $1.value })?.value else { return }

        let valuePoints = data.enumerated().map { CGPoint(x: CGFloat($0), y: CGFloat($1.value)) }
        let chartHeight = bounds.height / CGFloat(maxValue + topChartOffset)

        let lineWidth = bounds.width / CGFloat(valuePoints.count - 1)
        let points = valuePoints.map {
            let x = lineWidth * $0.x
            let y = bounds.height - $0.y * chartHeight

            return CGPoint(x: x, y: y)
        }

        let chartPath = UIBezierPath()
        chartPath.move(to: points[0])

        points.forEach { point in
            chartPath.addLine(to: point)
            drawChartDot(at: point)
        }

        let charLayer = CAShapeLayer()
        charLayer.path = chartPath.cgPath
        charLayer.fillColor = UIColor.clear.cgColor
        charLayer.strokeColor = UIColor.active.cgColor
        charLayer.lineWidth = 3
        charLayer.strokeEnd = 1
        charLayer.lineCap = .round
        charLayer.lineJoin = .round

        layer.addSublayer(charLayer)
    }

    func drawChartDot(at point: CGPoint) {
        let dotPath = UIBezierPath()
        dotPath.move(to: point)
        dotPath.addLine(to: point)

        let dotLayer = CAShapeLayer()
        dotLayer.path = dotPath.cgPath
        dotLayer.strokeColor = UIColor.active.cgColor
        dotLayer.lineCap = .round
        dotLayer.lineWidth = 10

        layer.addSublayer(dotLayer)
    }
}
