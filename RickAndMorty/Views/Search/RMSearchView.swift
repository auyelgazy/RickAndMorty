//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 06.10.2023.
//

import UIKit
import SnapKit

final class RMSearchView: UIView {

    private let viewModel: RMSearchViewViewModel

    // MARK: - Subviews

    // SearchInputView(bar, selection buttons)

    // No results view
    private let noResultsView = RMNoSearchResultsView()

    // Results collectionView

    // MARK: - Init
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(noResultsView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupConstraints() {
        noResultsView.snp.makeConstraints {
            $0.width.height.equalTo(150)
            $0.center.equalToSuperview()
        }
    }

}

// MARK: - CollectionView
extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
