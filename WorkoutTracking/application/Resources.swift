//
//  Resources.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

enum Resources {

    enum Strings {
        enum TabBar {
            static let overview = String(localized: "overview")
            static let session = String(localized: "session")
            static let progress = String(localized: "progress")
            static let settings = String(localized: "settings")
        }
    }

    enum Images{
        enum TabBar {
            static let overview = UIImage(systemName: "house")
            static let session = UIImage(systemName: "clock.arrow.2.circlepath")
            static let progress = UIImage(systemName: "chart.bar.xaxis.ascending.badge.clock")
            static let settings = UIImage(systemName: "gearshape")
        }
    }
}
