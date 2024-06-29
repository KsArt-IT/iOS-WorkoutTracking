//
//  ProgressController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class ProgressController: BaseController { }

extension ProgressController {
    override func setupViews() {
        super.setupViews()
    }

    override func constraintViews() {
        super.constraintViews()
    }

    override func configureAppearance() {
        super.configureAppearance()

        setTitle(of: .progress)

        addNavBarButton(of: .progress, at: .left)
        addNavBarButton(of: .progress, at: .right)
    }
}
