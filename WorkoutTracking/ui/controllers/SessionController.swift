//
//  SessionController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class SessionController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(of: .session)

        addNavBarButton(at: .left, with: Resources.Strings.Buttons.Left.session)
        addNavBarButton(at: .right, with: Resources.Strings.Buttons.Right.session)
    }

}

