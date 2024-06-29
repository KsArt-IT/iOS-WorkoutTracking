//
//  SessionController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class SessionController: BaseController { }

extension SessionController {
    override func setupViews() {
        super.setupViews()
    }

    override func constraintViews() {
        super.constraintViews()
    }

    override func configureAppearance() {
        super.configureAppearance()

        setTitle(of: .session)

        addNavBarButton(of: .session, at: .left)
        addNavBarButton(of: .session, at: .right)
    }
}
