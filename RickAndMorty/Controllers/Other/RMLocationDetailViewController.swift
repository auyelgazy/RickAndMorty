//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 06.10.2023.
//

import UIKit
import SnapKit

final class RMLocationDetailViewController: UIViewController, RMLocationDetailViewViewModelDelegate, RMLocationDetailViewDelegate {

    private let viewModel: RMLocationDetailViewViewModel

    private let detailView = RMLocationDetailView()

    // MARK: - Init

    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        setupConstraints()
        detailView.delegate = self
        title = "Location"

        viewModel.delegate = self
        viewModel.fetchLocationData()
    }

    private func setupConstraints() {
        detailView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - View Delegate

    func rmEpisodeDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}
