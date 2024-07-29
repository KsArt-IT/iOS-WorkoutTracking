//
//  SectionHeaderView.swift
//  WorkoutTracking
//
//  Created by KsArT on 23.07.2024.
//

import UIKit

final class TrainingViewHeader: UICollectionReusableView {

    static let id = "TrainingViewHeader"

    private let title: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 12)
        label.textColor = .inactive
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        constraintViews()
        configureAppearance()
    }

    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)

        setupViews()
        constraintViews()
        configureAppearance()
    }

    // MARK: - Configure View
    func configure(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd"

        self.title.text = dateFormatter.string(from: date).uppercased()
    }
}

// MARK: - Setup View
private extension TrainingViewHeader {

    func setupViews() {
        addSubview(title)
    }

    func constraintViews() {
        title.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configureAppearance() {
        backgroundColor = .clear
    }
}
