//
//  YSStopwatchView.swift
//  Clock-Combine
//
//  Created by yeonsu on 12/4/23.
//

import UIKit
import SnapKit

final class YSStopwatchView: UIView {
    
    // MARK: - Properties
    
    let labTableView = LabTableView()
    
    // MARK: - UI Components
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        let fontSize = UIFont.systemFont(ofSize: 200, weight: .thin)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: fontSize)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let startStopButton: UIButton = {
        let button = UIButton()
        let imageView =  UIImage(named: "stopwatch_btn_green")
        button.setBackgroundImage(imageView, for: .normal)
        button.setTitle("시작", for: .normal)
        button.setTitleColor(UIColor(named: "stopwatch_green"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        return button
    }()
    
    private let labResetButton: UIButton = {
        let button = UIButton()
        let imageView =  UIImage(named: "stopwatch_btn_gray")
        button.setBackgroundImage(imageView, for: .normal)
        button.setTitle("랩", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return button
    }()
    
    private let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions
extension YSStopwatchView {
    func setUI() {
        
    }
    
    func setHierarchy() {
        addSubviews(timerLabel, startStopButton, labResetButton, dividerLineView, labTableView)
    }
    
    func setLayout() {
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(120)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
        }
        startStopButton.snp.makeConstraints {
            $0.trailing.equalTo(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(86)
        }
        labResetButton.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(86)
        }
        dividerLineView.snp.makeConstraints {
            $0.top.equalTo(labResetButton.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(1)
        }
        labTableView.snp.makeConstraints {
            $0.top.equalTo(labResetButton.snp.bottom).offset(30)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setAddTarget() {
        
    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        
    }
    
    func setDataBind() {
        
    }
}

