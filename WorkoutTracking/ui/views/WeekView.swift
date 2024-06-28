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
    override func addViews() {
        super.addViews()

        addSubview(stackView)
    }

    override func layoutViews() {
        super.layoutViews()

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func configureViews() {
        super.configureViews()

        // отступы между элементами
        stackView.spacing = 8
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
