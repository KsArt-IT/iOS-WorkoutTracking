//
//  WeekDayView.swift
//  WorkoutTracking
//
//  Created by KsArT on 28.06.2024.
//

import UIKit

extension WeekView {
    final class WeekDayView: BaseView {

        private let nameLabel = UILabel()
        private let dateLabel = UILabel()
        private let stackView = UIStackView()

        func configure(with index: Int, and name: String, selected: Bool) {
            backgroundColor = selected ? .active : .background

            nameLabel.text = name.uppercased()
            nameLabel.textColor = selected ? .white : .inactive
            dateLabel.text = "\(index)"
            dateLabel.textColor = selected ? .white : .inactive
        }
    }
}

extension WeekView.WeekDayView {
    override func addViews() {
        super.addViews()

        addSubview(stackView)

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dateLabel)
    }

    override func layoutViews() {
        super.layoutViews()

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Resources.Constant.tiny),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Resources.Constant.tiny),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func configureViews() {
        super.configureViews()

        layer.cornerRadius = Resources.Constant.small
        layer.masksToBounds = true

        nameLabel.font = Resources.Fonts.helvelticaRegular(with: 9)
        nameLabel.textAlignment = .center

        dateLabel.font = Resources.Fonts.helvelticaRegular(with: 15)
        dateLabel.textAlignment = .center

        // отступы между элементами
        stackView.spacing = Resources.Constant.tiny
        // сделать вертикальным, потому что он горизонталный
        stackView.axis = .vertical
    }
}
