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

        configureAppearance()
//        switchTo(tab: .session)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func switchTo(tab: Tabs) {
        guard tab.rawValue >= 0 && tab.rawValue < tabBar.items?.count ?? 0 else { return }

        selectedIndex = tab.rawValue
    }

    private func configureAppearance() {
        tabBar.tintColor = .active
        tabBar.barTintColor = .inactive
        tabBar.backgroundColor = .white

        tabBar.layer.borderColor = UIColor.ribbon.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true

        let controllers = Tabs.allCases.map(getNavBarController)

        setViewControllers(controllers, animated: false)
    }

    private func getNavBarController(of tab: Tabs) -> NavBarController {
        let navBar = NavBarController(rootViewController: getTabController(tab))
        navBar.tabBarItem = getTabBarItem(tab)
        return navBar
    }

    private func getTabController(_ tab: Tabs) -> BaseController {
        switch tab {
            case .overview: OverviewController()
            case .session: SessionController()
            case .progress: ProgressController()
            case .settings: SettingsController()
        }
    }

    private func getTabBarItem(_ tab: Tabs) -> UITabBarItem {
        UITabBarItem(
            title: R.Strings.TabBar.getTitle(tab),
            image: R.Images.TabBar.getIcon(tab),
            tag: tab.rawValue
        )
    }

}

enum Tabs: Int, CaseIterable {
    case overview
    case session
    case progress
    case settings
}
