//
//  WorldCityListViewModel.swift
//  Clock-Combine
//
//  Created by sejin on 12/6/23.
//

import Foundation
import Combine

final class WorldCityListViewModel {
    
    var cities = [String]()
    
    func transform(viewDidLoad: AnyPublisher<Void, Never>) -> AnyPublisher<Void, Never> {
        return viewDidLoad.map { _ in
            self.getCityNames()
        }.eraseToAnyPublisher()
    }
    
    private func getCityNames() {
        self.cities = TimeZone.knownTimeZoneIdentifiers.map { timeZoneId in
            let timeZone = TimeZone(identifier: timeZoneId)
            let translatedName: String = timeZone?.localizedName(for: NSTimeZone.NameStyle.shortGeneric, locale: Locale(identifier: "ko_KR")) ?? ""
            return translatedName
        }
    }
}
