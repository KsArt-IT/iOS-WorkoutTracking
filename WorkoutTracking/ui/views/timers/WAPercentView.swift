//
//  WAPercentView.swift
//  WorkoutTracking
//
//  Created by KsArT on 08.07.2024.
//

import UIKit

extension WATimerView {
    final class PercentView: BaseView {

        private let stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.distribution = .fillProportionally
            view.spacing = R.Constant.tiny
            return view
        }()

        private let percentLabel: UILabel = {
            let label = UILabel()
            label.font = R.Fonts.helvelticaRegular(with: 23)
            label.textColor = .titleGray
            label.textAlignment = .center
            return label
        }()

        private let subTitleLabel: UILabel = {
            let label = UILabel()
            label.font = R.Fonts.helvelticaRegular(with: 10)
            label.textColor = .inactive
            label.textAlignment = .center
            return label
        }()

        func configure(for title: String, with value: Int) {
            subTitleLabel.text = title.uppercased()
            percentLabel.text = "\(value)%"
        }
    }
}

extension WATimerView.PercentView {

    override func setupViews() {
        super.setupViews()

        addSubview(stackView)
        stackView.addArrangedSubview(percentLabel)
        stackView.addArrangedSubview(subTitleLabel)
    }

    override func constraintViews() {
        super.constraintViews()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
