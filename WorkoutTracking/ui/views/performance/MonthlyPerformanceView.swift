//
//  MonthlyPerformanceView.swift
//  WorkoutTracking
//
//  Created by KsArT on 22.07.2024.
//

import UIKit

final class MonthlyPerformanceView: BaseInfoView {

    private let chartsView = ChartsView()

    // MARK: - Configure View
    func configure(with data: [ChartsView.Data], of topChartOffset: Int) {
        chartsView.configure(with: data, of: topChartOffset)
    }
}

// MARK: - Setup View
extension MonthlyPerformanceView {

    override func setupViews() {
        super.setupViews()

        addSubview(chartsView)
    }

    override func constraintViews() {
        super.constraintViews()

        chartsView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chartsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: R.Constant.small),
            chartsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: R.Constant.small),
            chartsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Constant.small),
            chartsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -R.Constant.small),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
    }
}
