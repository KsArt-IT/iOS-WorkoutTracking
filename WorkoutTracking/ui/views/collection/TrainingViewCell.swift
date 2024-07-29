//
//  TrainingViewCell.swift
//  WorkoutTracking
//
//  Created by KsArT on 23.07.2024.
//

import UIKit

final class TrainingViewCell: UICollectionViewCell {

    static let id = "TrainingViewCell"

    private let checkView = UIImageView(image: R.Images.Common.checkmarkNotDovn)

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = R.Constant.minimal
        return view
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 16)
        label.textColor = .titleGray
        return label
    }()
    private let subtitle: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 12)
        label.textColor = .inactive
        return label
    }()
    private let rightArrowView:UIImageView = {
        let view = UIImageView(image: R.Images.Common.rightArrow)
        view.tintColor = .inactive
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        constraintViews()
        configureAppearance()
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
        constraintViews()
        configureAppearance()
    }

    // MARK: - Configure View
    func configure(with title: String, and subtitle: String, isDone: Bool, roundedType: CellRoundedType) {
        self.title.text = title
        self.subtitle.text = subtitle

        checkView.image = isDone ? R.Images.Common.checkmarkDovn : R.Images.Common.checkmarkNotDovn
        checkView.tintColor = isDone ? .active : .inactive

        // Обновите расположение перед скруглением
        layoutIfNeeded()

        switch roundedType {
            case .all: self.roundCorners([.allCorners], radius: R.Constant.Collection.cornerRadius)
            case .bottom: self.roundCorners([.bottomLeft, .bottomRight], radius: R.Constant.Collection.cornerRadius)
            case .top: self.roundCorners([.topLeft, .topRight], radius: R.Constant.Collection.cornerRadius)
            case .notRounded: self.roundCorners([.allCorners], radius: 0)
        }
    }
}

// MARK: - Setup View
private extension TrainingViewCell {

    func setupViews() {
        addSubview(checkView)
        addSubview(stackView)
        addSubview(rightArrowView)

        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
    }

    func constraintViews() {
        checkView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        rightArrowView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            checkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: R.Constant.medium),
            checkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkView.heightAnchor.constraint(equalToConstant: R.Constant.largeIconSize),
            checkView.widthAnchor.constraint(equalToConstant: R.Constant.largeIconSize),

            stackView.leadingAnchor.constraint(equalTo: checkView.trailingAnchor, constant: R.Constant.medium),
            stackView.trailingAnchor.constraint(equalTo: rightArrowView.leadingAnchor, constant: -R.Constant.medium),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            rightArrowView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: R.Constant.medium),
            rightArrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -R.Constant.medium),
            rightArrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrowView.heightAnchor.constraint(equalToConstant: R.Constant.Arrow.height),
            rightArrowView.widthAnchor.constraint(equalToConstant: R.Constant.Arrow.width),
        ])
    }

    func configureAppearance() {
        backgroundColor = .clear
    }
}

enum CellRoundedType {
    case top, bottom, all, notRounded

    static func getType(count: Int, at index: Int) -> CellRoundedType {
        let roundedType: CellRoundedType
        if index == 0 {
            if count == 1 {
                // если только 1 элемент
                roundedType = .all
            } else {
                // верхний
                roundedType = .top
            }
        } else if index == count - 1 {
            // последний
            roundedType = .bottom
        } else {
            // в середине
            roundedType = .notRounded
        }
        return roundedType
    }
}
