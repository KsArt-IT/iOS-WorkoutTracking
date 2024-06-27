//
//  BaseController.swift
//  WorkoutTracking
//
//  Created by KsArT on 24.06.2024.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        layoutViews()
        configure()
    }
}

extension BaseController {
    func setTitle(of tab: Tabs) {
        // при установке титла окна меняется и tabBarItem.title, поэтому переназначаем
        let titles: Titles = Resources.Strings.Title.get(of: tab)
        title = titles.navBar
        navigationController?.tabBarItem.title = titles.tabBar
    }

    func addNavBarButton(at position: NavBarPosition, with title: String) {
        let button = getButton(with: title)

        switch position {
            case .left:
                button.addTarget(self, action: #selector(navBarLeftButtonHandler), for: .touchUpInside)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            case .right:
                button.addTarget(self, action: #selector(navBarRightButtonHandler), for: .touchUpInside)
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }

    private func getButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Resources.Fonts.helvelticaRegular()
        button.setTitleColor(.active, for: .normal)
        button.setTitleColor(.inactive, for: .disabled)

        return button
    }
}

@objc extension BaseController {
    func addViews() {

    }

    func layoutViews() {

    }

    func configure() {
        view.backgroundColor = .background
    }

    func navBarLeftButtonHandler() {

    }
    
    func navBarRightButtonHandler() {

    }

    func secondaryButtonHandler() {

    }
}
