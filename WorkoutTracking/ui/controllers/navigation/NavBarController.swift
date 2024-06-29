//
//  NavBarController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

final class NavBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        view.backgroundColor = .white

        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.titleGray,
            .font: Resources.Fonts.helvelticaRegular(with: 17)
        ]

        navigationBar.addBottomBorder(with: .ribbon, height: 1)
    }
}

enum NavBarPosition {
    case left
    case right
}
