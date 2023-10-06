//
//  RMEpisodeListView.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 05.10.2023.
//

import UIKit
import SnapKit

protocol RMEpisodeListViewDelegate: AnyObject {
    func rmEpisodeListView(
        _ characterListView: RMEpisodeListView,
        didSelectEpisode episode: RMEpisode
    )
}

/// View that handles showing list of episodes, loader, etc.
final class RMEpisodeListView: UIView {
    
    public weak var delegate: RMEpisodeListViewDelegate?
    
    private let viewModel = RMEpisodeListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifer)
        collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(collectionView, spinner)
        setupConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchEpisodes()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupConstraints() {
        spinner.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension RMEpisodeListView: RMEpisodeListViewViewModelDelegate {
    func didLoadInitialEpisodes() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectEpisode(_ episode: RMEpisode) {
        delegate?.rmEpisodeListView(self, didSelectEpisode: episode)
    }
}
