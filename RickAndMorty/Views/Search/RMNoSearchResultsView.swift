//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 06.10.2023.
//

import UIKit
import SnapKit

final class RMNoSearchResultsView: UIView {
    
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemBlue
        return iconView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        addSubviews(iconView, label)
        setupConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupConstraints() {
        iconView.snp.makeConstraints {
            $0.width.height.equalTo(90)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(iconView.snp.bottom).offset(10)
        }
    }
    
    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
}
