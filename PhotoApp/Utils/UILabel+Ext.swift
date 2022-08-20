//
//  Init+Ext.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 16/08/2022.
//

import UIKit

extension UILabel {
    convenience init(
        title: String = "",
        numberOfLines: Int = 1,
        font: UIFont = .systemFont(ofSize: 16, weight: .regular),
        alignment: NSTextAlignment = .left,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        self.init(frame: .zero)
        self.text = title
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.lineBreakMode = .byTruncatingTail
    }
}
