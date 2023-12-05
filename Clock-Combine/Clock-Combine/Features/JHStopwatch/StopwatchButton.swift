//
//  StopwatchButton.swift
//  Clock-Combine
//
//  Created by ParkJunHyuk on 2023/12/05.
//

import UIKit

enum StopwatchButtonType {
    
    case start
    case reset
    case stop
    case lap

    var title: String {
        switch self {
        case .start:
            return "시작"
        case .reset:
            return "재설정"
        case .stop:
            return "중단"
        case .lap:
            return "랩"
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .start:
            return .systemGreen
        case .reset, .lap:
            return .white
        case .stop:
            return .systemRed
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .start:
            return UIColor(red: 9/255, green: 42/255, blue: 19/255, alpha: 1)
        case .reset, .lap:
            return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        case .stop:
            return UIColor(red: 51/255, green: 14/255, blue: 11/255, alpha: 1)
        }
    }
}

final class StopwatchButton: UIButton {
    
    var titleType: StopwatchButtonType {
        didSet {
            setUI()
            print("버튼 값 변경")
        }
    }
    private let width = 84
    
    init(type: StopwatchButtonType) {
        self.titleType = type
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StopwatchButton {
    
    private func setUI() {
        self.backgroundColor = titleType.backgroundColor
        self.layer.cornerRadius = CGFloat(width / 2)
        
        self.setTitle(titleType.title, for: .normal)
        self.setTitleColor(titleType.titleColor, for: .normal)
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.height.equalTo(84)
        }
    }
}
