//
//  SecondaryButton.swift
//  WorkoutTracking
//
//  Created by KsArT on 27.06.2024.
//

import UIKit

public enum WAButtonType {
    case plain
    case filled
}

final class WAButton: UIButton {

    private let label = UILabel()
    private let icon = UIImageView()

    private var type = WAButtonType.plain
    private var activeColor = UIColor.clear

    override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }

    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    init(of type: WAButtonType) {
        super.init(frame: .zero)
        self.type = type
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        configure()
    }

    private func configure() {
        setupViews()
        constraintViews()
        configureAppearance()
    }

    func setTitle(_ title: String?) {
        label.text = title
    }
}

private extension WAButton {
    func setupViews() {
        addSubview(label)
        addSubview(icon)
    }

    func constraintViews() {
        let horizontalOffset: CGFloat = type == .plain ? 0 : 10

        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalOffset),
            icon.heightAnchor.constraint(equalToConstant: 5),
            icon.widthAnchor.constraint(equalToConstant: 10),

            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalOffset * 2)
        ])
    }

    func configureAppearance() {
        switch type {
            case .plain:
                label.font = R.Fonts.helvelticaRegular(with: 13)
                activeColor = .inactive
                backgroundColor = .clear
            case .filled:
                label.font = R.Fonts.helvelticaRegular(with: 15)
                activeColor = .active
                layer.cornerRadius = R.Constant.Buttons.cornerRadius
                backgroundColor = .secondary
        }
        makeSystem(self)
        updateAppearance()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = R.Images.Common.downArrow.withRenderingMode(.alwaysTemplate)
    }

    func updateAppearance() {
        if isHighlighted {
            label.textColor = activeColor.withAlphaComponent(0.3)
            icon.tintColor = activeColor.withAlphaComponent(0.3)
        } else if !isEnabled {
            label.textColor = .inactive
            icon.tintColor = .inactive
        } else {
            label.textColor = activeColor
            icon.tintColor = activeColor
        }
    }
}
