//
//  OverviewController.swift
//  WorkoutTracking
//
//  Created by KsArT on 17.06.2024.
//

import UIKit

class OverviewController: BaseController {

    private let navBar = OverviewNavBar()

    override func viewDidLoad() {
        super.viewDidLoad()

//        setTitle(of: .overview)
    }

}

extension OverviewController {
    override func addViews() {
        super.addViews()

        view.addSubview(navBar)
    }

    override func layoutViews() {
        super.layoutViews()

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    override func configure() {
        super.configure()

        navigationController?.navigationBar.isHidden = true

        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.addAllWorkoutsAction(#selector(navBarLeftButtonHandler), with: self)
        navBar.addAddAction(#selector(navBarRightButtonHandler), with: self)
    }

}
