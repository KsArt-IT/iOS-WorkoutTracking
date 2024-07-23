//
//  DailyPerformenceView.swift
//  WorkoutTracking
//
//  Created by KsArT on 22.07.2024.
//

import UIKit

final class DailyPerformanceView: BaseInfoView {

    private let barsView = BarsView()

    // MARK: - Configure View
    func configure(with items: [BarView.Data]) {
        barsView.configure(with: items)
    }
}

// MARK: - Setup View
extension DailyPerformanceView {

    override func setupViews() {
        super.setupViews()

        addSubview(barsView)
    }

    override func constraintViews() {
        super.constraintViews()

        barsView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            barsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: R.Constant.small),
            barsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: R.Constant.small),
            barsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Constant.small),
            barsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -R.Constant.small),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
    }
}
