//
//  SecondaryButton.swift
//  WorkoutTracking
//
//  Created by KsArT on 27.06.2024.
//

import UIKit

final class SecondaryButton: UIButton {

    private let label = UILabel()
    private let icon = UIImageView()
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ title: String) {
        label.text = title
    }
}

private extension SecondaryButton {
    func setupViews() {
        addSubview(label)
        addSubview(icon)
    }

    func constraintViews() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            icon.heightAnchor.constraint(equalToConstant: 5),
            icon.widthAnchor.constraint(equalToConstant: 10),

            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
    }

    func configureAppearance() {
        layer.cornerRadius = R.Constant.Buttons.cornerRadius
        makeSystem(self)
        updateAppearance()
        backgroundColor = .secondary

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = R.Fonts.helvelticaRegular(with: 15)

        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = R.Images.Common.downArrow.withRenderingMode(.alwaysTemplate)
    }

    func updateAppearance() {
        if isHighlighted {
            label.textColor = .highlighted
            icon.tintColor = .highlighted
        } else if !isEnabled {
            label.textColor = .inactive
            icon.tintColor = .inactive
        } else {
            label.textColor = .active
            icon.tintColor = .active
        }
    }
}
