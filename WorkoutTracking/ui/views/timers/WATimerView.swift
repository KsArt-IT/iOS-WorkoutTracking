//
//  WATimerView.swift
//  WorkoutTracking
//
//  Created by KsArT on 01.07.2024.
//

import UIKit

final class WATimerView: BaseInfoView {
    
    private let elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 14)
        label.text = R.Strings.Timer.elapsedTime
        label.textColor = .inactive
        label.textAlignment = .center
        return label
    }()
    private let elapsedTimeValueLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 46)
        label.textColor = .titleGray
        label.textAlignment = .center
        return label
    }()

    private let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 13)
        label.text = R.Strings.Timer.remainingTime
        label.textColor = .inactive
        label.textAlignment = .center
        return label
    }()
    private let remainingTimeValueLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 13)
        label.textColor = .titleGray
        label.textAlignment = .center
        return label
    }()
    
    private let timeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = R.Constant.small
        return view
    }()

    // для отображения нижних меток с процентом
    private let bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = R.Constant.medium
        view.distribution = .fill
        return view
    }()
    private let completedPercentView = PercentView()
    private let remainingPercentView = PercentView()
    private let bottomSeparotorView: UIView = {
        let view = UIView()
        view.backgroundColor = .inactive
        return view
    }()

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

    @MainActor required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with duration: Double, progress: Double) {
        timerDuration = duration
        timerCountdown = duration / 12

        // чтобы progress не был больше duration
        let currentValue = progress > duration ? duration : progress

        // целевое состояние, если больше 0, то берем его, иначе 1
        let deviderValue = duration > 0 ? duration : 1
        let percent: CGFloat = currentValue / deviderValue
        let roundedPercent: Int = Int(round(percent*100))

        // установим время
        elapsedTimeValueLabel.text = getTimeToDisplay(from: currentValue)
        remainingTimeValueLabel.text = getTimeToDisplay(from: duration - currentValue)

        // установим процент
        completedPercentView.configure(for: R.Strings.Timer.completedPercent, with: roundedPercent)
        remainingPercentView.configure(for: R.Strings.Timer.remainingPercent, with: 100 - roundedPercent)

        // нарисуем дугу прогресса
        progressView.drawProgress(with: percent)
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
            if self.isTimerFinished() {
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
            if self.isTimerFinished(reverse: true) {
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

}

private extension WATimerView {

    // получить форматированное время в часах, минутах и секундах
    func getTimeToDisplay(from value: Double) -> String {
        let value: Int = Int(value)
        
        let seconds: Int = value % 60
        let minutes: Int = value / 60 % 60
        let hours: Int = value / 3600

        return hours > 0 ? String(format: "%02d:%02d:%02d", hours, minutes, seconds) : String(format: "%02d:%02d", minutes, seconds)
    }

    func tickTimer(_ timeInterval: Double) {
        // изменение прогресса таймера
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

    func isTimerFinished(reverse: Bool = false) -> Bool {
        timerProgress == (reverse ? 0 : timerDuration)
    }

    func getSecondsPassed() -> Double {
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
        addSubview(timeStackView)
        addSubview(bottomStackView)

        // стек вью для времени
        [
            elapsedTimeLabel,
            elapsedTimeValueLabel,
            remainingTimeLabel,
            remainingTimeValueLabel
        ].forEach(timeStackView.addArrangedSubview)

        // стек вью для процентного соотношения завершения
        [
            completedPercentView,
            bottomSeparotorView,
            remainingPercentView
        ].forEach(bottomStackView.addArrangedSubview)
    }

    override func constraintViews() {
        super.constraintViews()

        progressView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor),

            timeStackView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            timeStackView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),

            bottomStackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -50),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 35),

            bottomSeparotorView.widthAnchor.constraint(equalToConstant: 1)
        ])
    }

    func getState() -> TimerState {
        timerState
    }

}

enum TimerState {
    case started
    case paused
    case stoped
}
