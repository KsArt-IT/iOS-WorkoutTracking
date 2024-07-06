//
//  WATimerView.swift
//  WorkoutTracking
//
//  Created by KsArT on 01.07.2024.
//

import UIKit

final class WATimerView: BaseInfoView {

    private let progressView = WAProgressView()
    
    private var timer: Timer? = nil
    private var timerProgress: CGFloat = 0
    private var timerDuration = 0.0
    private var timerDurationStop = 0.0
    private var timerState = TimerState.stoped

    func configure(with duration: Double, progress: Double) {
        timerDuration = duration
        timerDurationStop = 0.05 * duration

        // чтобы progress не был больше duration
        let currentValue = progress > duration ? duration : progress

        // целевое состояние, если больше 0, то берем его, иначе 1
        let deviderValue = duration > 0 ? duration : 1
        let percent: CGFloat = currentValue / deviderValue

        progressView.drawProgress(with: percent)
    }

    func getState() -> TimerState {
        timerState
    }

    func startTimer(_ completion: @escaping () -> Void) {
        // остановим прошлый или паузу?
        timer?.invalidate()
        timerState = .started
        // запустим новый со старыми значениями
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.tickTimer(timer.timeInterval)
            if self.isEndTimer() {
                timer.invalidate()
                timerState = .stoped
                completion()
            }
        }
    }

    func stopTimer(_ completion: @escaping () -> Void) {
        timer?.invalidate()

        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.tickTimer(-timerDurationStop)
            if self.isEndTimer(reverse: true) {
                timer.invalidate()
                timerState = .stoped
                completion()
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        timerState = .paused
    }

    private func tickTimer(_ timeInterval: Double) {
        timerProgress += timeInterval
        if timeInterval > 0 {
            if timerProgress > timerDuration {
                timerProgress = timerDuration
            }
        } else {
            if timerProgress <= 0 {
                timerProgress = 0
            }
        }
        configure(with: timerDuration, progress: timerProgress)
    }

    private func isEndTimer(reverse: Bool = false) -> Bool {
        timerProgress == (reverse ? 0 : timerDuration)
    }
}

extension WATimerView {
    override func setupViews() {
        super.setupViews()

        addSubview(progressView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        progressView.translatesAutoresizingMaskIntoConstraints = false
    }

}

enum TimerState {
    case started
    case paused
    case stoped
}
