//
//  WATimerView.swift
//  WorkoutTracking
//
//  Created by KsArT on 01.07.2024.
//

import UIKit

final class WATimerView: BaseInfoView {

    // вью для отображения прогресса
    private let progressView = WAProgressView()
    
    // таймер
    private var timer: Timer? = nil

    // прогресс, сколько прошло, сек
    private var timerProgress = 0.0
    // время таймера, сек
    private var timerDuration = 0.0
    // обратный отсчет
    private var timerCountdown = 0.0
    // состояние таймера
    private var timerState = TimerState.stoped

    // дата начала замера для таймера
    private var timerStart = Date()
    // интервал вызова таймера, сек (24 раза в секунду)
    private let interval = 0.05

    func configure(with duration: Double, progress: Double) {
        timerDuration = duration
        timerCountdown = 3 * interval * duration

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
        // сохраним текущее время для подсчета интервала
        timerStart = Date()
        // запустим новый со старыми значениями
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            // изменяем на прошедшее время
            self.tickTimer(getSecondsPassed())
            if self.isEndTimer() {
                timer.invalidate()
                timerState = .stoped
                completion()
            }
        }
        timer?.tolerance = 0.1 * interval
    }

    func stopTimer(_ completion: @escaping () -> Void) {
        timer?.invalidate()

        self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.tickTimer(-timerCountdown)
            if self.isEndTimer(reverse: true) {
                timer.invalidate()
                timerState = .stoped
                completion()
            }
        }
        timer?.tolerance = interval
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

    private func getSecondsPassed() -> Double {
        // секунд прошло от прошлой проверки + поправка
        let seconds = -timerStart.timeIntervalSinceNow + 0.0001
        timerStart = Date()
        return seconds
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
