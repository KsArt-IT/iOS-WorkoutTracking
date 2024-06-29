//
//  OverviewController.swift
//  WorkoutTracking
//
//  Created by KsArT on 17.06.2024.
//

import UIKit

class OverviewController: BaseController {

    private let navBar = OverviewNavBar()

}

extension OverviewController {
    override func setupViews() {
        super.setupViews()

        view.addSubview(navBar)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        navigationController?.navigationBar.isHidden = true

        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.addAllWorkoutsAction(#selector(navBarLeftButtonHandler), with: self)
        navBar.addAddAction(#selector(navBarRightButtonHandler), with: self)
    }

}
