//
//  WeekView.swift
//  WorkoutTracking
//
//  Created by KsArT on 28.06.2024.
//

import UIKit

final class WeekView: BaseView {

    private let stackView = UIStackView()

}

extension WeekView {
    override func setupViews() {
        super.setupViews()

        addSubview(stackView)
    }

    override func constraintViews() {
        super.constraintViews()

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        // отступы между элементами
        stackView.spacing = Resources.Constant.small
        // сделать равными по ширине
        stackView.distribution = .fillEqually

        let weekdays = CalendarExt.getWeekDaysShort()
        weekdays.forEach { name, day, selected in
            let view = WeekDayView()
            view.configure(with: day, and: name, selected: selected)

            stackView.addArrangedSubview(view)
        }
    }
}
