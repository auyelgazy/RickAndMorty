//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 05.10.2023.
//

import UIKit
import SnapKit

/// Interface to relay location view events
protocol RMLocationViewDelegate: AnyObject {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation)
}

final class RMLocationView: UIView {
    
    public weak var delegate: RMLocationViewDelegate?
    
    private var viewModel: RMLocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
            
            viewModel?.registerDidFinishPaginationBlock { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.alpha = 0
        table.isHidden = true
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(tableView, spinner)
        spinner.startAnimating()
        setupConstraints()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        spinner.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func configure(with viewModel: RMLocationViewViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDelegate

extension RMLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        delegate?.rmLocationView(self, didSelect: locationModel)
    }
}

// MARK: - UITableViewDataSource

extension RMLocationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RMLocationTableViewCell.cellIdentifier,
            for: indexPath
        ) as? RMLocationTableViewCell else {
            fatalError()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension RMLocationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel,
              !viewModel.cellViewModels.isEmpty,
              viewModel.shouldShowLoadMoreIndicator,
              !viewModel.isLoadingMoreLocations else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.showLoadingIndicator()
                viewModel.fetchAdditionalLocations()
            }
            t.invalidate()
        }
    }
    
    private func showLoadingIndicator() {
        let footer = RMTableLoadingFooterView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        tableView.tableFooterView = footer
    }
}
