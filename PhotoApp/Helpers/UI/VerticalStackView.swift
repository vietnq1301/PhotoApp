//
//  VerticalStackView.swift
//  PhotoApp
//
//  Created by Nguyễn Việt on 19/08/2022.
//

import UIKit

class VerticalStackView: UIStackView {
    init(
        arrangedSubviews: [UIView],
        spacing: CGFloat = 0,
        alignment: UIStackView.Alignment = .leading,
        distribution: UIStackView.Distribution = .fillEqually
    ) {
        super.init(frame: .zero)
        arrangedSubviews.forEach{addArrangedSubview($0)}
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
