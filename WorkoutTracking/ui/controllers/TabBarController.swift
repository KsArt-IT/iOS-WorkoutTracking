//
//  TabBarController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = .active
        tabBar.barTintColor = .inactive
        tabBar.backgroundColor = .white

        tabBar.layer.borderColor = UIColor.ribbon.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true

        setViewControllers(
            [
                getNavBarController(of: .overview),
                getNavBarController(of: .session),
                getNavBarController(of: .progress),
                getNavBarController(of: .settings),
            ],
            animated: false
        )
    }

    private func getNavBarController(of tab: Tabs) -> NavBarController {
        let navBar = NavBarController(rootViewController: getTabController(tab))
        navBar.tabBarItem = getTabBarItem(tab)
        return navBar
    }

    private func getTabController(_ tab: Tabs) -> BaseController {
        switch tab {
            case Tabs.overview: OverviewController()
            case Tabs.session: SessionController()
            case Tabs.progress: ProgressController()
            case Tabs.settings: SettingsController()
        }
    }

    private func getTabBarItem(_ tab: Tabs) -> UITabBarItem {
        UITabBarItem(
            title: getTabTitle(tab),
            image: getTabImage(tab),
            tag: tab.rawValue
        )
    }

    private func getTabTitle(_ tab: Tabs) -> String {
        switch tab {
            case Tabs.overview: Resources.Strings.TabBar.overview
            case Tabs.session: Resources.Strings.TabBar.session
            case Tabs.progress: Resources.Strings.TabBar.progress
            case Tabs.settings: Resources.Strings.TabBar.settings
        }
    }

    private func getTabImage(_ tab: Tabs) -> UIImage {
        switch tab {
            case Tabs.overview: Resources.Images.TabBar.overview
            case Tabs.session: Resources.Images.TabBar.session
            case Tabs.progress: Resources.Images.TabBar.progress
            case Tabs.settings: Resources.Images.TabBar.settings
        }
    }

}
