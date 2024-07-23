//
//  ProgressController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class ProgressController: BaseController { 

    private let dailyPerformanceView = DailyPerformanceView(with: R.Strings.Progress.dailyPerformance, buttonTitle: R.Strings.Progress.last7Days)

    private let monthlyPerformanceView = MonthlyPerformanceView(with: R.Strings.Progress.monthlyPerformance, buttonTitle: R.Strings.Progress.last10Months)
}

extension ProgressController {
    override func setupViews() {
        super.setupViews()

        view.addSubview(dailyPerformanceView)
        view.addSubview(monthlyPerformanceView)
    }

    override func constraintViews() {
        super.constraintViews()

        dailyPerformanceView.translatesAutoresizingMaskIntoConstraints = false
        monthlyPerformanceView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dailyPerformanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: R.Constant.medium),
            dailyPerformanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Constant.medium),
            dailyPerformanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Constant.medium),
            dailyPerformanceView.heightAnchor.constraint(equalTo: dailyPerformanceView.widthAnchor, multiplier: 0.55),

            monthlyPerformanceView.topAnchor.constraint(equalTo: dailyPerformanceView.bottomAnchor, constant: R.Constant.medium),
            monthlyPerformanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Constant.medium),
            monthlyPerformanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Constant.medium),
            monthlyPerformanceView.heightAnchor.constraint(equalTo: dailyPerformanceView.widthAnchor, multiplier: 0.90),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        setTitle(of: .progress)

        addNavBarButton(of: .progress, at: .left)
        addNavBarButton(of: .progress, at: .right)
        
        let weekDaysShort = CalendarExt.getWeekDaysShort()
        let monthsShort = CalendarExt.getMonthsShort()
        if !weekDaysShort.isEmpty {
            dailyPerformanceView.configure(with: [
                .init(value: "1", heightMultiplier: 0.2, title: weekDaysShort[0].week),
                .init(value: "2", heightMultiplier: 0.4, title: weekDaysShort[1].week),
                .init(value: "3", heightMultiplier: 0.6, title: weekDaysShort[2].week),
                .init(value: "4", heightMultiplier: 0.8, title: weekDaysShort[3].week),
                .init(value: "5", heightMultiplier: 1, title: weekDaysShort[4].week),
                .init(value: "3", heightMultiplier: 0.6, title: weekDaysShort[5].week),
                .init(value: "2", heightMultiplier: 0.4, title: weekDaysShort[6].week),
            ])
        }

        if !monthsShort.isEmpty {
            monthlyPerformanceView.configure(with: [
                .init(value: 45, title: monthsShort[0].month),
                .init(value: 55, title: monthsShort[1].month),
                .init(value: 60, title: monthsShort[2].month),
                .init(value: 65, title: monthsShort[3].month),
                .init(value: 70, title: monthsShort[4].month),
                .init(value: 80, title: monthsShort[5].month),
                .init(value: 65, title: monthsShort[6].month),
                .init(value: 45, title: monthsShort[7].month),
                .init(value: 30, title: monthsShort[8].month),
                .init(value: 15, title: monthsShort[9].month),
            ],
                                             of: 10
            )
        }
    }
}
