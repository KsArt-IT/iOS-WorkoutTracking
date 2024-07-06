//
//  SessionController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class SessionController: BaseController { 
    private let timerView = WATimerView()

    private let timerDuration = 3.0

    override func navBarLeftButtonHandler() {
        // start/pause
        if timerView.getState() == TimerState.started {
            timerView.pauseTimer()
        } else {
            timerView.startTimer { [weak self] in
                guard let self else { return }

                self.setTitleForNavBarButton(of: .session, at: .left, started: self.timerView.getState() == .paused)
            }
        }
        setTitleForNavBarButton(of: .session, at: .left, started: timerView.getState() != .paused)
    }

    override func navBarRightButtonHandler() {
        // stop
        timerView.stopTimer { [weak self] in
            guard let self else { return }

            self.setTitleForNavBarButton(of: .session, at: .left, started: self.timerView.getState() == .paused)
        }
    }
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

        timerView.configure(with: timerDuration, progress: 0)
    }
}
