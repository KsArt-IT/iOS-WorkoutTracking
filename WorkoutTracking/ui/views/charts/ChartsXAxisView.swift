//
//  ChartsXAxisView.swift
//  WorkoutTracking
//
//  Created by KsArT on 22.07.2024.
//

import UIKit

final class ChartsXAxisView: BaseView {

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()

    // MARK: - Configure View
    func configure(with data: [ChartsView.Data]) {
        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }

        data.forEach { 
            let label = UILabel()
            label.font = R.Fonts.helvelticaRegular(with: 9)
            label.textColor = .inactive
            label.textAlignment = .center
            label.text = $0.title.uppercased()
            stackView.addArrangedSubview(label)
        }
    }
}

// MARK: - Setup View
extension ChartsXAxisView {

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

