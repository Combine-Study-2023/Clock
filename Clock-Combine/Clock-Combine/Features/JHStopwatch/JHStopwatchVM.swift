//
//  JHStopwatchVM.swift
//  Clock-Combine
//
//  Created by ParkJunHyuk on 2023/12/05.
//

import Combine
import Foundation

final class JHStopwatchVM {
    
    let leftButtonSubject = PassthroughSubject<StopwatchButtonType, Never>()
    let rightButtonSubject = PassthroughSubject<Bool, Never>()
    
    @Published var currentTime: String = "00:00.00"
    @Published var currentLapTime: String = "00:00.00"
    @Published var lapTime: [String] = []
    
    var isTimerRunning = false
    private var cancellables = Set<AnyCancellable>()
    
    private var timer: AnyCancellable?
    private var lapTimer: AnyCancellable?
    
    private var lapNum = 0
    
    init() {
        rightButtonSubject
            .sink { [weak self] isSelected in
                if isSelected {
                    self?.startTimer()
                    self?.startLapTimer()
                } else {
                    self?.stopTimer()
                    self?.stopLapTimer()
                    self?.lapNum = 0
                }
            }
            .store(in: &cancellables)
        
        leftButtonSubject
            .sink { [weak self] type in
                if type == .lap {
                    self?.stopLapTimer()
                    self?.startLapTimer()
                    self?.lapNum += 1
                } else {
                    self?.currentTime = "00:00.00"
                    self?.lapTime.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    private func startTimer() {

        var seconds = 0
        isTimerRunning = true
        timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()

            .sink { [weak self] _ in
                guard let self = self else { return }
                seconds += 1
                
                let formattedTime = self.formatTime(seconds: seconds)
                self.currentTime = formattedTime 
            }
    }
    
    private func startLapTimer() {
        var seconds = 0
        lapTimer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                seconds += 1
                
                let formattedTime = self.formatTime(seconds: seconds)
                self.currentLapTime = formattedTime
                self.lapTime[lapNum] = self.currentLapTime
                print(self.currentLapTime)
            }
        
        self.lapTime.append(currentLapTime)
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    func stopLapTimer() {
        lapTimer?.cancel()
        lapTimer = nil
    }
    
    private func formatTime(seconds: Int) -> String {

        let minutes = (seconds / 100) / 60
        let secs = (seconds / 100) % 60
        let milliseconds = (seconds % 100)
        
        return String(format: "%02d:%02d.%02d", minutes, secs, milliseconds)
    }
}
