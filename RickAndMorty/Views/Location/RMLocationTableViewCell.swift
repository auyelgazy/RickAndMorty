//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 05.10.2023.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {
    static let cellIdentifier = "RMLocationTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    public func configure(with viewModel: RMLocationTableViewCellViewModel) {

    }
}
