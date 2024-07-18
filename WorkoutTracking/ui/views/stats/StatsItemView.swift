//
//  StatsItemView.swift
//  WorkoutTracking
//
//  Created by KsArT on 15.07.2024.
//

import UIKit

final class StatsItemView: BaseView {

    // структура данных
    struct ItemData {
        let image: UIImage
        let value: String
        let title: String
    }

    // MARK: - Elements
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 17)
        label.textColor = .titleGray
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 10)
        label.textColor = .inactive
        return label
    }()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    // MARK: - Configure View
    public func configure(with item: ItemData) {
        imageView.image = item.image
        valueLabel.text = item.value
        titleLabel.text = item.title.uppercased()
    }
}

// MARK: - Setup View
extension StatsItemView {

    override func setupViews() {
        super.setupViews()

        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(titleLabel)
    }

    override func constraintViews() {
        super.constraintViews()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: R.Constant.iconSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: R.Constant.medium),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: R.Constant.small)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
    }

}
