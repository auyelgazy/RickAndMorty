//
//  RMTableLoadingFooterView.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 06.10.2023.
//

import UIKit
import SnapKit

final class RMTableLoadingFooterView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(spinner)
        spinner.startAnimating()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        spinner.snp.makeConstraints {
            $0.width.height.equalTo(55)
            $0.center.equalToSuperview()
        }
    }
    
}
