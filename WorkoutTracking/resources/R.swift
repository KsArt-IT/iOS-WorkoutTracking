//
//  Resources.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

enum R {

    enum Strings {
        enum TabBar {
            static func getTitle(_ tab: Tabs) -> String {
                switch tab {
                    case .overview: String(localized: "overviewTabBar")
                    case .session: String(localized: "sessionTabBar")
                    case .progress: String(localized: "progressTabBar")
                    case .settings: String(localized: "settingsTabBar")
                }
            }
        }

        enum NavBar {
            static func getTitle(_ tab: Tabs) -> String {
                switch tab {
                    case .overview: String(localized: "overviewTitle")
                    case .session: String(localized: "sessionTitle")
                    case .progress: String(localized: "progressTitle")
                    case .settings: String(localized: "settingsTitle")
                }
            }
        }

        enum Buttons {
            enum Common {
                static let allWorkouts  = String(localized: "buttonAllWorkouts")
            }

            static func getTitle(of tab: Tabs, at position: NavBarPosition) -> String {
                switch position {
                    case .left:
                        switch tab {
                            case .overview: String(localized: "overviewNavBarButtonLeft")
                            case .session: String(localized: "sessionNavBarButtonLeft")
                            case .progress: String(localized: "progressNavBarButtonLeft")
                            case .settings: String(localized: "settingsNavBarButtonLeft")
                        }
                    case .right:
                        switch tab {
                            case .overview: String(localized: "overviewNavBarButtonRight")
                            case .session: String(localized: "sessionNavBarButtonRight")
                            case .progress: String(localized: "progressNavBarButtonRight")
                            case .settings: String(localized: "settingsNavBarButtonRight")
                        }
                }
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
            static func getIcon(_ tab: Tabs) -> UIImage {
                switch tab {
                    case .overview: UIImage(systemName: "house") ?? UIImage()
                    case .session: UIImage(systemName: "clock.arrow.2.circlepath") ?? UIImage()
                    case .progress: UIImage(systemName: "chart.bar.xaxis.ascending.badge.clock") ?? UIImage()
                    case .settings: UIImage(systemName: "gearshape") ?? UIImage()
                }
            }
        }
    }

    enum Fonts {
        static func helvelticaRegular(with size: CGFloat = 17) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }

    enum Constant {
        static let minimal: CGFloat = 2
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 32

        static let cornerRadius: CGFloat = 6

        enum Buttons {
            static let height: CGFloat = 28
            static let cornerRadius: CGFloat = height / 2
            static let size: CGFloat = 30
        }
    }
}
