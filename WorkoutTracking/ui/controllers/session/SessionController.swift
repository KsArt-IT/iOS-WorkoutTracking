//
//  SessionController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class SessionController: BaseController { 
    private let timerView = WATimerView()

    private let timerDuration = 60.0

    private let statsView = StatsView(with: R.Strings.Session.workuotStatus)
    private let stepsView = StepsView(with: R.Strings.Session.stepsCounter)

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
        view.addSubview(statsView)
        view.addSubview(stepsView)
    }

    override func constraintViews() {
        super.constraintViews()

        timerView.translatesAutoresizingMaskIntoConstraints = false
        statsView.translatesAutoresizingMaskIntoConstraints = false
        stepsView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: R.Constant.medium),
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Constant.medium),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Constant.medium),

            statsView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: R.Constant.small),
            statsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Constant.medium),
            statsView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -R.Constant.small),
            statsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),

            stepsView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: R.Constant.small),
            stepsView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: R.Constant.small),
            stepsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Constant.medium),
            stepsView.bottomAnchor.constraint(equalTo:  statsView.bottomAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        setTitle(of: .session)

        addNavBarButton(of: .session, at: .left)
        addNavBarButton(of: .session, at: .right)


        timerView.configure(with: timerDuration, progress: 0)

        statsView.configure(with: [
            .heartRate(value: "155"),
            .averagePace(value: "9'20''"),
            .totalSteps(value: "7,682"),
            .totalDistance(value: "8.25"),
        ])

        stepsView.configure(with: [
            .init(value: "8k", heightMultiplier: 1, title: "2/14"),
            .init(value: "7k", heightMultiplier: 0.8, title: "2/15"),
            .init(value: "5k", heightMultiplier: 0.6, title: "2/16"),
            .init(value: "1k", heightMultiplier: 0.1, title: "2/17"),
        ])
    }
}
