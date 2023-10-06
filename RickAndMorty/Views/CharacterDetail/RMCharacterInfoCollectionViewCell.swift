//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 05.10.2023.
//

import UIKit
import SnapKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterInfoCollectionViewCell"

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()

    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()

    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(titleContainerView, valueLabel, iconImageView)
        titleContainerView.addSubview(titleLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupConstraints() {
        titleContainerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(contentView.frame.height * 0.33)
        }

        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.top.equalToSuperview().offset(35)
            $0.left.equalToSuperview().offset(20)
        }

        valueLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(iconImageView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalTo(titleContainerView.snp.top)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label
    }

    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}

