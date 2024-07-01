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

        setupViews()
        constraintViews()
        configureAppearance()
    }
}

extension BaseController {
    func setTitle(of tab: Tabs) {
        // при установке титла окна меняется и tabBarItem.title, поэтому переназначаем
        title = R.Strings.NavBar.getTitle(tab)
        navigationController?.tabBarItem.title = R.Strings.TabBar.getTitle(tab)
    }

    func addNavBarButton(of tab: Tabs, at position: NavBarPosition) {
        let title = R.Strings.Buttons.getTitle(of: tab, at: position)
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
        button.titleLabel?.font = R.Fonts.helvelticaRegular()
        button.setTitleColor(.active, for: .normal)
        button.setTitleColor(.inactive, for: .disabled)

        return button
    }
}

@objc extension BaseController {
    func setupViews() {

    }

    func constraintViews() {

    }

    func configureAppearance() {
        view.backgroundColor = .background
    }

    func navBarLeftButtonHandler() {

    }
    
    func navBarRightButtonHandler() {

    }

}
