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

        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ title: String) {
        label.text = title
    }
}

private extension SecondaryButton {
    func addViews() {
        addSubview(label)
        addSubview(icon)
    }

    func layoutViews() {
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

    func configure() {
        layer.cornerRadius = Resources.Constant.Buttons.cornerRadius
        makeSystem(self)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Resources.Fonts.helvelticaRegular(with: 15)

        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = Resources.Images.Common.downArrow.withRenderingMode(.alwaysTemplate)
    }

    func updateAppearance() {
        if isHighlighted {
            backgroundColor = .secondaryHighlighted
            label.textColor = .highlighted
            icon.tintColor = .highlighted
        } else if !isEnabled {
            backgroundColor = .secondary
            label.textColor = .inactive
            icon.tintColor = .inactive
        } else {
            backgroundColor = .secondary
            label.textColor = .active
            icon.tintColor = .active
        }
    }
}
