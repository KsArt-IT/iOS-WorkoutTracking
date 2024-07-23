//
//  BarView.swift
//  WorkoutTracking
//
//  Created by KsArT on 18.07.2024.
//

import UIKit

final class BarView: BaseView {

    private var heightMultiplier: Double

    // MARK: - Elements
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 13)
        label.textColor = .active
        return label
    }()
    private let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .active
        view.layer.cornerRadius = R.Constant.Bars.cornerRadius
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 9)
        label.textColor = .inactive
        return label
    }()

    // MARK: - init View
    init(data: BarView.Data) {
        self.heightMultiplier = data.heightMultiplier
        super.init(frame: .zero)

        valueLabel.text = data.value
        titleLabel.text = data.title.uppercased()
    }
    
    @MainActor required init?(coder: NSCoder) {
        self.heightMultiplier = 1
        super.init(coder: coder)
    }
}

// MARK: - Setup View
extension BarView {

    override func setupViews() {
        super.setupViews()

        addSubview(valueLabel)
        addSubview(barView)
        addSubview(titleLabel)
    }

    override func constraintViews() {
        super.constraintViews()

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        barView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            barView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: R.Constant.small),
            barView.centerXAnchor.constraint(equalTo: centerXAnchor),
            barView.widthAnchor.constraint(equalToConstant: R.Constant.Bars.width),
            barView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightMultiplier * 0.75),

            titleLabel.topAnchor.constraint(equalTo: barView.bottomAnchor, constant: R.Constant.small),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .clear
    }
}

// MARK: - Data
extension BarView {

    struct Data {
        let value: String
        let heightMultiplier: Double
        let title: String
    }
}
