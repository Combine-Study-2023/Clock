//
//  UIView+.swift
//  Clock-Combine
//
//  Created by sejin on 2023/11/22.
//

import UIKit

extension UIView {
    
    // UIView 여러 개 인자로 받아서 한 번에 addSubview
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
