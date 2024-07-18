//
//  StatsItem.swift
//  WorkoutTracking
//
//  Created by KsArT on 18.07.2024.
//

import Foundation

enum StatsItem {
    // параметры для отображения статистики в 
    case heartRate(value: String)
    case averagePace(value: String)
    case totalSteps(value: String)
    case totalDistance(value: String)

    // тестовые данные для статистики
    func getData() -> StatsItemView.ItemData {
        switch self {
            case .heartRate(let value): .init(
                image: R.Images.Session.heartRate,
                value: "\(value) bpm",
                title: R.Strings.Session.heartRate
            )
            case .averagePace(let value): .init(
                image: R.Images.Session.averagePace,
                value: "\(value) / km",
                title: R.Strings.Session.averagePace
            )
            case .totalSteps(let value): .init(
                image: R.Images.Session.totalSteps,
                value: "\(value)",
                title: R.Strings.Session.totalSteps
            )
            case .totalDistance(let value): .init(
                image: R.Images.Session.totalDistance,
                value: "\(value) km",
                title: R.Strings.Session.totalDistance
            )
        }
    }
}
