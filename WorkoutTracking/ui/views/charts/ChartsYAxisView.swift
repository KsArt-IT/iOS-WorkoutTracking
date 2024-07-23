//
//  ChartsYAxisView.swift
//  WorkoutTracking
//
//  Created by KsArT on 22.07.2024.
//

import UIKit

final class ChartsYAxisView: BaseView {

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()

    // MARK: - Configure View
    func configure(with data: [ChartsView.Data]) {
        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }

        (0..<10).reversed().forEach { i in
            let label = UILabel()
            label.font = R.Fonts.helvelticaRegular(with: 9)
            label.textColor = .inactive
            label.textAlignment = .right
            label.text = "\(i * 10)"
            stackView.addArrangedSubview(label)
        }
    }
}

// MARK: - Setup View
extension ChartsYAxisView {

    override func setupViews() {
        super.setupViews()

        addSubview(stackView)
    }

    override func constraintViews() {
        super.constraintViews()

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .clear
    }
}
