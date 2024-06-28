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
            static let overview = String(localized: "overviewTabBar")
            static let session = String(localized: "sessionTabBar")
            static let progress = String(localized: "progressTabBar")
            static let settings = String(localized: "settingsTabBar")
        }

        enum Title {
            static let overview = String(localized: "overviewTitle")
            static let session = String(localized: "sessionTitle")
            static let progress = String(localized: "progressTitle")
            static let settings = String(localized: "settingsTitle")

            static func get(of tab: Tabs) -> Titles {
                switch tab {
                    case .overview:
                        ("", Resources.Strings.TabBar.overview)
                    case .session:
                        (Resources.Strings.Title.session, Resources.Strings.TabBar.session)
                    case .progress:
                        (Resources.Strings.Title.progress, Resources.Strings.TabBar.progress)
                    case .settings:
                        (Resources.Strings.Title.settings, Resources.Strings.TabBar.settings)
                }
            }
        }

        enum Buttons {
            enum Common {
                static let allWorkouts  = String(localized: "buttonAllWorkouts")
            }

            enum Left {
                static let overview = String(localized: "overviewNavBarButtonLeft")
                static let session = String(localized: "sessionNavBarButtonLeft")
                static let progress = String(localized: "progressNavBarButtonLeft")
                static let settings = String(localized: "settingsNavBarButtonLeft")
            }
            
            enum Right {
                static let overview = String(localized: "overviewNavBarButtonRight")
                static let session = String(localized: "sessionNavBarButtonRight")
                static let progress = String(localized: "progressNavBarButtonRight")
                static let settings = String(localized: "settingsNavBarButtonRight")
            }
        }
    }

    enum Images{
        // Создание конфигурации символа с масштабом Large
        private static let large = UIImage.SymbolConfiguration(scale: .large)

        enum Common {
            static let downArrow = UIImage(systemName: "chevron.down") ?? UIImage()
            static let plusCircleFill = UIImage(systemName: "plus.circle.fill") ?? UIImage()
            // Применение конфигурации к изображению
            static let plusCircleFillLarge = UIImage(systemName: "plus.circle.fill")?.withConfiguration(large) ?? UIImage()
        }

        enum TabBar {
            static let overview = UIImage(systemName: "house") ?? UIImage()
            static let session = UIImage(systemName: "clock.arrow.2.circlepath") ?? UIImage()
            static let progress = UIImage(systemName: "chart.bar.xaxis.ascending.badge.clock") ?? UIImage()
            static let settings = UIImage(systemName: "gearshape") ?? UIImage()
        }
    }

    enum Fonts {
        static func helvelticaRegular(with size: CGFloat = 17) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }

    enum Constant {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 32

        enum Buttons {
            static let cornerRadius: CGFloat = 14
            static let height: CGFloat = 28
            static let size: CGFloat = 30
        }
    }
}

typealias Titles = (navBar: String, tabBar: String)

enum Tabs: Int {
    case overview
    case session
    case progress
    case settings
}

enum NavBarPosition {
    case left
    case right
}
