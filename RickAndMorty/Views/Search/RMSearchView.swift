//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 06.10.2023.
//

import UIKit
import SnapKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
    func rmSearchView(_ searchView: RMSearchView, didSelectLocation location: RMLocation)
    func rmSearchView(_ searchView: RMSearchView, didSelectCharacter character: RMCharacter)
    func rmSearchView(_ searchView: RMSearchView, didSelectEpisode episode: RMEpisode)
}

final class RMSearchView: UIView {
    
    weak var delegate: RMSearchViewDelegate?
    
    private let viewModel: RMSearchViewViewModel
    
    // MARK: - Subviews
    
    // SearchInputView(bar, selection buttons)
    private let searchInputView = RMSearchInputView()
    
    // No results view
    private let noResultsView = RMNoSearchResultsView()
    
    // Results collectionView
    private let resultsView = RMSearchResultsView()
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(resultsView, noResultsView, searchInputView)
        setupConstraints()
        
        searchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
        searchInputView.delegate = self
        
        setupHandlers(viewModel: viewModel)
        
        resultsView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupHandlers(viewModel: RMSearchViewViewModel) {
        
        viewModel.registerNoResultsHandler { [weak self] in
            DispatchQueue.main.async {
                self?.noResultsView.isHidden = false
                self?.resultsView.isHidden = true
            }
        }
        
        viewModel.registerOptionChangeBlock { tuple in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
        
        viewModel.registerSearchResultHandler { [weak self] result in
            DispatchQueue.main.async {
                self?.resultsView.configure(with: result)
                self?.noResultsView.isHidden = true
                self?.resultsView.isHidden = false
            }
        }
    }
    
    private func setupConstraints() {
        noResultsView.snp.makeConstraints {
            $0.width.height.equalTo(150)
            $0.center.equalToSuperview()
        }
        
        searchInputView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(viewModel.config.type == .episode ? 55 : 110)
        }
        
        resultsView.snp.makeConstraints {
            $0.top.equalTo(searchInputView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
    
}

// MARK: - RMSearchResultsViewDelegate

extension RMSearchView: RMSearchResultsViewDelegate {
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapLocationAt index: Int) {
        guard let locationModel = viewModel.locationSearchResult(at: index) else {
            return
        }
        delegate?.rmSearchView(self, didSelectLocation: locationModel)
    }
    
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapEpisodeAt index: Int) {
        guard let episodeModel = viewModel.episodeSearchResult(at: index) else {
            return
        }
        delegate?.rmSearchView(self, didSelectEpisode: episodeModel)
    }
    
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapCharacterAt index: Int) {
        guard let characterModel = viewModel.characterSearchResult(at: index) else {
            return
        }
        delegate?.rmSearchView(self, didSelectCharacter: characterModel)
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

// MARK: - RMSearchInputViewDelegate

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearchText text: String) {
        viewModel.set(query: text)
    }
    
    func rmSearchInputViewDidTapSearchKeyboardButton(_ inputView: RMSearchInputView) {
        viewModel.executeSearch()
    }
}
