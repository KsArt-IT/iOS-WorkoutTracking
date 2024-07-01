//
//  BaseInfoView.swift
//  WorkoutTracking
//
//  Created by KsArT on 29.06.2024.
//

import UIKit

class BaseInfoView: BaseView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 13)
        label.textColor = .inactive
        label.text = "Test".uppercased()
        return label
    }()

    private let button = WAButton(of: .plain)

    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.ribbon.cgColor
        view.layer.cornerRadius = R.Constant.cornerRadius
        return view
    }()

    init(with title: String? = nil, alignment: NSTextAlignment = .center, buttonTitle: String? = nil) {
        titleLabel.text = title?.uppercased()
        titleLabel.textAlignment = buttonTitle == nil ? alignment : .left
        titleLabel.isHidden = title == nil

        button.setTitle(buttonTitle)
        button.isHidden = buttonTitle == nil

        // порядок важен, установка констрейтов после задания титла
        super.init(frame: .zero)
    }
    
    @MainActor required convenience init?(coder: NSCoder) {
        self.init()
    }
}

extension BaseInfoView {

    override func setupViews() {
        super.setupViews()

        addSubview(titleLabel)
        addSubview(button)
        addSubview(contentView)
    }

    override func constraintViews() {
        super.constraintViews()

        let contentTopAnchor: NSLayoutAnchor = titleLabel.text == nil ? topAnchor : titleLabel.bottomAnchor
        let contentTopOffset: CGFloat = titleLabel.text == nil ? 0 : 10

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            contentView.topAnchor.constraint(equalTo: contentTopAnchor, constant: contentTopOffset),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .clear

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }

    func addButtonTarget(target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }

}
