//
//  SessionController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class SessionController: BaseController { 
    private let timerView: BaseInfoView = {
        let view = BaseInfoView(with: "Test", alignment: .center)

        return view
    }()
}

extension SessionController {
    override func setupViews() {
        super.setupViews()

        view.addSubview(timerView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: R.Constant.medium),
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Constant.medium),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Constant.medium),
            timerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        setTitle(of: .session)

        addNavBarButton(of: .session, at: .left)
        addNavBarButton(of: .session, at: .right)

        timerView.translatesAutoresizingMaskIntoConstraints = false

    }
}
