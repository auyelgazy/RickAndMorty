//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 18.02.2023.
//

import UIKit
import SnapKit

/// Controller to show and search for Episodes
final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {

    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
        setupView()
        addSearchButton()
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }

    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        episodeListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Delegate

    func rmEpisodeListView(_ characterListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        // Open detail controller for that episode
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
