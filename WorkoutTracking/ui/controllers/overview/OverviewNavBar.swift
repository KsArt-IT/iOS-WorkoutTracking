//
//  OverviewNavBar.swift
//  WorkoutTracking
//
//  Created by KsArT on 28.06.2024.
//

import UIKit

final class OverviewNavBar: BaseView {

    private let titleLabel = UILabel()
    private let allWorkoutsButton = SecondaryButton()
    private let addButton = UIButton()
    private let weekView = WeekView()

    override func layoutSubviews() {
        super.layoutSubviews()

        addBottomBorder()
    }

    func addAllWorkoutsAction(_ action: Selector, with target: Any?) {
        allWorkoutsButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func addAddAction(_ action: Selector, with target: Any?) {
        addButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension OverviewNavBar {

    override func setupViews() {
        super.setupViews()

        addSubview(titleLabel)
        addSubview(allWorkoutsButton)
        addSubview(addButton)
        addSubview(weekView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Resources.Constant.small),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Resources.Constant.medium),
            addButton.heightAnchor.constraint(equalToConstant: Resources.Constant.Buttons.size),
            addButton.widthAnchor.constraint(equalToConstant: Resources.Constant.Buttons.size),

            allWorkoutsButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            allWorkoutsButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -Resources.Constant.small),
            allWorkoutsButton.heightAnchor.constraint(equalToConstant: Resources.Constant.Buttons.height),

            titleLabel.centerYAnchor.constraint(equalTo: allWorkoutsButton.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: allWorkoutsButton.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Resources.Constant.medium),

            weekView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: Resources.Constant.small),
            weekView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Resources.Constant.medium),
            weekView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Resources.Constant.medium),
            weekView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Resources.Constant.small),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Resources.Strings.NavBar.getTitle(.overview)
        titleLabel.textColor = .titleGray
        titleLabel.font = Resources.Fonts.helvelticaRegular(with: 22)

        allWorkoutsButton.translatesAutoresizingMaskIntoConstraints = false
        allWorkoutsButton.setTitle(Resources.Strings.Buttons.Common.allWorkouts)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(Resources.Images.Common.plusCircleFillLarge, for: .normal)
        addButton.tintColor = .active
        // Настройка углов в стиле Capsule
        addButton.layer.cornerRadius = Resources.Constant.Buttons.size / 2
        addButton.clipsToBounds = true

        weekView.translatesAutoresizingMaskIntoConstraints = false
    }
}

