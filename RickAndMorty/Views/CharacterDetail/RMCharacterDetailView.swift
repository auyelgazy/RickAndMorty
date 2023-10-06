//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 21.02.2023.
//

import UIKit
import SnapKit

/// View for single characrer info
final class RMCharacterDetailView: UIView {
    
    public var collectionView: UICollectionView?
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupConstraints() {
        spinner.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        guard let collectionView = collectionView else { return }
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterPhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifer)
        collectionView.register(RMCharacterInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifer)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifer)
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .information:
            return viewModel.createInfoSectionLayout()
        case .episodes:
            return viewModel.createEpisodeSectionLayout()
        }
    }
}
