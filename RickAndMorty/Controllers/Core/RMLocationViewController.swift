//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 18.02.2023.
//

import UIKit
import SnapKit

/// Controller to show and search for Locations
class RMLocationViewController: UIViewController, RMLocationViewViewModelDelegate {

    private let primaryView = RMLocationView()

    private let viewModel = RMLocationViewViewModel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Locations"
        view.addSubviews(primaryView)
        addSearchButton()
        setupConstraints()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }

    private func setupConstraints() {
        primaryView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }

    @objc private func didTapSearch() {

    }

    // MARK: - LocationViewModel Delegate

    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}
