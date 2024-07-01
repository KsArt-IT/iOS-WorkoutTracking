//
//  WATimerView.swift
//  WorkoutTracking
//
//  Created by KsArT on 01.07.2024.
//

import UIKit

final class WATimerView: BaseInfoView {

    private let progressView: WAProgressView = {
        let view = WAProgressView()
        view.drawProgress(with: 0.7)
        return view
    }()
}

extension WATimerView {
    override func setupViews() {
        super.setupViews()

        addSubview(progressView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        progressView.translatesAutoresizingMaskIntoConstraints = false
    }

}
