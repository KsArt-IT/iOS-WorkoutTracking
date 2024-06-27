//
//  ProgressController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class ProgressController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(of: .progress)

        addNavBarButton(at: .left, with: Resources.Strings.Buttons.Left.progress)
        addNavBarButton(at: .right, with: Resources.Strings.Buttons.Right.progress)

    }


}

