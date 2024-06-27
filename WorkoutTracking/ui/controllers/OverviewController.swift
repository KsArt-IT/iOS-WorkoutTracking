//
//  OverviewController.swift
//  WorkoutTracking
//
//  Created by KsArT on 17.06.2024.
//

import UIKit

class OverviewController: BaseController {

    private let allWorkoutsButton = SecondaryButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(of: .overview)
    }

}

extension OverviewController {
    override func addViews() {
        super.addViews()

        view.addSubview(allWorkoutsButton)
    }

    override func layoutViews() {
        super.layoutViews()

        NSLayoutConstraint.activate([
            allWorkoutsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            allWorkoutsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allWorkoutsButton.heightAnchor.constraint(equalToConstant: Resources.Constant.Buttons.height),
        ])
    }

    override func configure() {
        super.configure()

        allWorkoutsButton.translatesAutoresizingMaskIntoConstraints = false
        allWorkoutsButton.setTitle(Resources.Strings.Buttons.Common.allWorkouts)
        allWorkoutsButton.addTarget(self, action: #selector(secondaryButtonHandler), for: .touchUpInside)
    }

    override func secondaryButtonHandler() {
        print("allWorkouts button tap")
    }
}
