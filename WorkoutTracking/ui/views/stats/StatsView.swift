//
//  StatsView.swift
//  WorkoutTracking
//
//  Created by KsArT on 15.07.2024.
//

import UIKit

final class StatsView: BaseInfoView {

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = R.Constant.medium
        view.distribution = .fillEqually
        return view
    }()

    // MARK: - Configure View
    func configure(with items: [StatsItem]) {
        items.forEach { item in
            let itemView = StatsItemView()
            itemView.configure(with: item.getData())
            stackView.addArrangedSubview(itemView)
        }
    }
}

// MARK: - Setup View
extension StatsView {

    override func setupViews() {
        super.setupViews()

        addSubview(stackView)
    }

    override func constraintViews() {
        super.constraintViews()

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: R.Constant.small),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: R.Constant.medium),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Constant.medium)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

    }
}
