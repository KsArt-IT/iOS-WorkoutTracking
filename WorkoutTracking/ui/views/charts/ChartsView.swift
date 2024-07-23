//
//  ChartsView.swift
//  WorkoutTracking
//
//  Created by KsArT on 22.07.2024.
//

import UIKit

final class ChartsView: BaseView {

    private let xAxisView = ChartsXAxisView()
    private let yAxisView = ChartsYAxisView()

    private let chartView = ChartView()

    // MARK: - Configure View
    func configure(with data: [ChartsView.Data], of topChartOffset: Int) {
        xAxisView.configure(with: data)
        yAxisView.configure(with: data)

        chartView.configure(with: data, of: topChartOffset)
    }
}

// MARK: - Setup View
extension ChartsView {

    override func setupViews() {
        super.setupViews()

        addSubview(yAxisView)
        addSubview(xAxisView)
        addSubview(chartView)
    }

    override func constraintViews() {
        super.constraintViews()

        xAxisView.translatesAutoresizingMaskIntoConstraints = false
        yAxisView.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            yAxisView.leadingAnchor.constraint(equalTo: leadingAnchor),
            yAxisView.topAnchor.constraint(equalTo: topAnchor),
            yAxisView.bottomAnchor.constraint(equalTo: xAxisView.topAnchor, constant: -R.Constant.tiny),

            xAxisView.leadingAnchor.constraint(equalTo: yAxisView.trailingAnchor, constant: R.Constant.tiny),
            xAxisView.trailingAnchor.constraint(equalTo: trailingAnchor),
            xAxisView.bottomAnchor.constraint(equalTo: bottomAnchor),

            chartView.leadingAnchor.constraint(equalTo: yAxisView.trailingAnchor, constant: R.Constant.small),
            chartView.topAnchor.constraint(equalTo: topAnchor, constant: R.Constant.tiny),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -R.Constant.small),
            chartView.bottomAnchor.constraint(equalTo: xAxisView.topAnchor, constant: -R.Constant.small),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .clear
    }
}

extension ChartsView {

    struct Data {
        let value: Int
        let title: String
    }
}
