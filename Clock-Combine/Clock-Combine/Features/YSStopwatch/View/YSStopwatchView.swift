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
    
    let lapTableView = LapTableView()
    private let stopwatch: Stopwatch = Stopwatch()
    private let lapStopwatch: Stopwatch = Stopwatch()
    private let lapTimeLabel = LabTableViewCell().diffLabel
    private var isPlay: Bool = false
    var lapTableviewData: [String] = []
    var diffTableViewData: [String] = []
    
    // MARK: - UI Components
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        
        let fontSize = UIFont.systemFont(ofSize: 88, weight: .thin)
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
    
    private let lapResetButton: UIButton = {
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
        
        lapResetButton.isEnabled = false
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
        addSubviews(timerLabel, startStopButton, lapResetButton, dividerLineView, lapTableView)
    }
    
    func setLayout() {
        timerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(180)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
        }
        startStopButton.snp.makeConstraints {
            $0.trailing.equalTo(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(86)
        }
        lapResetButton.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(86)
        }
        dividerLineView.snp.makeConstraints {
            $0.top.equalTo(lapResetButton.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(1)
        }
        lapTableView.snp.makeConstraints {
            $0.top.equalTo(lapResetButton.snp.bottom).offset(30)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setAddTarget() {
        lapResetButton.addTarget(self, action: #selector(lapResetButtonTapped), for: .touchUpInside)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func lapResetButtonTapped() {
        if !isPlay {
            resetLapTimer()
            diffTableViewData.removeAll()
            resetMainTimer()
            changeButton(lapResetButton, title: "랩", titleColor: UIColor.white)
            lapResetButton.isEnabled = false
        } else {
            if let timerLabelText = timerLabel.text {
                lapTableviewData.append(timerLabelText)
            }
            if let diffLabelText = lapTimeLabel.text {
                diffTableViewData.append(diffLabelText)
            }
            lapTableView.tableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
        }
    }
    
    @objc
    func startStopButtonTapped() {
        lapResetButton.isEnabled = true
        changeButton(lapResetButton, title: "랩", titleColor: UIColor.white)
        if !isPlay {
            unowned let weakSelf = self
            
            stopwatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(stopwatch.timer, forMode: RunLoop.Mode.common)
            
            
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            changeButton(startStopButton, title: "중단", titleColor: UIColor.red)
            startStopButton.setBackgroundImage(UIImage(named: "stopwatch_btn_red"), for: .normal)
        }
        else {
            stopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(startStopButton, title: "시작", titleColor: UIColor.green)
            startStopButton.setBackgroundImage(UIImage(named: "stopwatch_btn_green"), for: .normal)
            changeButton(lapResetButton, title: "재설정", titleColor: UIColor.white)
        }
    }
    
    @objc func updateMainTimer() {
        updateTimer(stopwatch, label: timerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimeLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.01
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
    }
    
    func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimeLabel)
    }
    
    func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    func resetMainTimer() {
        resetTimer(stopwatch, label: timerLabel)
        lapTableviewData.removeAll()
        lapTableView.tableView.reloadData()
    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        
    }
    
    func setDataBind() {
        
    }
}

fileprivate extension Selector {
    static let updateMainTimer = #selector(YSStopwatchView.updateMainTimer)
    static let updateLapTimer = #selector(YSStopwatchView.updateLapTimer)
}

