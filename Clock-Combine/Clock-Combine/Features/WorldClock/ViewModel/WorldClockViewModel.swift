//
//  WorldClockViewModel.swift
//  Clock-Combine
//
//  Created by sejin on 12/6/23.
//

import Foundation
import Combine

final class WorldClockViewModel {
    let wordTimeList = CurrentValueSubject<[WorldTimeModel], Never>([])
    
    
    func addCity(data: WorldCityData) {
        let model = WorldTimeModel(name: data.0, time: getTimeFromTimeZone(timezone: data.1), difference: "")
        self.wordTimeList.send(wordTimeList.value + [model])
    }
    
    func getTimeFromTimeZone(timezone: TimeZone) -> String {
        // 1. 현재시각 생성
        let worldDate = Date()

        // 2. 타임존으로 시차 적용
        var selectedWorld = Date.FormatStyle.dateTime
        selectedWorld.timeZone = timezone

        var time = worldDate.formatted(selectedWorld).split(separator: " ")
        time.removeFirst()

        return "\(time.first!)"
    }
}
