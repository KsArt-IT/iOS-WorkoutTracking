//
//  OverviewController.swift
//  WorkoutTracking
//
//  Created by KsArT on 17.06.2024.
//

import UIKit

class OverviewController: BaseController {

    private let navBar = OverviewNavBar()

    private var dataSource: [TraningData] = []

    private let collectionView: UICollectionView = {
        // создаем слой, как будет отображаться
        let layout = UICollectionViewFlowLayout()
        // растояние между ячейками
        layout.minimumLineSpacing = 0

        // создаем коллекцию
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear

        return view
    }()
}

// MARK: - Setup View
extension OverviewController {
    override func setupViews() {
        super.setupViews()

        view.addSubview(navBar)
        view.addSubview(collectionView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Constant.medium),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Constant.medium),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        navigationController?.navigationBar.isHidden = true

        navBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        navBar.addAllWorkoutsAction(#selector(navBarLeftButtonHandler), with: self)
        navBar.addAddAction(#selector(navBarRightButtonHandler), with: self)

        collectionView.register(TrainingViewCell.self, forCellWithReuseIdentifier: TrainingViewCell.id)
        collectionView.register(TrainingViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrainingViewHeader.id)

        collectionView.delegate = self
        collectionView.dataSource = self

        loadData()
    }

    private func loadData() {
        guard let week = CalendarExt.getThreeDaysOfWeek() else { return }

        dataSource = [
            .init(
                date: week.first,
                items: [
                    .init(
                        title: "High Intensity Cardio",
                        subtitle: "Treadmill • 50 minutes",
                        isDone: CalendarExt.isDateTodayOrPast(fromDate: week.first)
                    ),
                ]
            ),
            .init(
                date: week.second,
                items: [
                    .init(
                        title: "Warm Up Cardio",
                        subtitle: "Stair Climber • 10 minutes",
                        isDone: CalendarExt.isDateTodayOrPast(fromDate: week.second)
                    ),
                    .init(
                        title: "Chest Workout",
                        subtitle: "Bench Press • 3 sets • 10 reps",
                        isDone: CalendarExt.isDateTodayOrPast(fromDate: week.second)
                    ),
                    .init(
                        title: "Tricep Workout",
                        subtitle: "Overhead Extension • 5 sets • 8 reps",
                        isDone: CalendarExt.isDateTodayOrPast(fromDate: week.second)
                    ),
                ]
            ),
            .init(
                date: week.third,
                items: [
                    .init(
                        title: "Cardio Interval Workout",
                        subtitle: "Treadmill • 60 minutes",
                        isDone: CalendarExt.isDateTodayOrPast(fromDate: week.third)
                    ),
                    .init(
                        title: "Chest Workout",
                        subtitle: "Bench Press • 3 sets • 10 reps",
                        isDone: CalendarExt.isDateTodayOrPast(fromDate: week.third)
                    ),
                    .init(
                        title: "Tricep Workout",
                        subtitle: "Overhead Extension • 5 sets • 8 reps",
                        isDone: CalendarExt.isDateTodayOrPast(fromDate: week.third)
                    ),
                ]
            )
        ]
        collectionView.reloadData()
    }

}

// MARK: - Collection DataSource
extension OverviewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrainingViewCell.id, for: indexPath
        ) as? TrainingViewCell else { return UICollectionViewCell() }

        let item = dataSource[indexPath.section].items[indexPath.row]

        let roundedType = CellRoundedType.getType(count: dataSource[indexPath.section].items.count, at: indexPath.row)

        cell.configure(with: item.title, and: item.subtitle, isDone: item.isDone, roundedType: roundedType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: TrainingViewHeader.id, for: indexPath
        ) as? TrainingViewHeader else { return UICollectionReusableView() }

        view.configure(with: dataSource[indexPath.section].date)
        return view
    }
}

// MARK: - Collection Delegate
extension OverviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: R.Constant.Collection.sizeItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: R.Constant.Collection.sizeHeader)
    }
}

struct TraningData {
    struct Data {
        let title: String
        let subtitle: String
        let isDone: Bool
    }

    let date: Date
    let items: [Data]
}
