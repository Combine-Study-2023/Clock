//
//  WorldCityListViewModel.swift
//  Clock-Combine
//
//  Created by sejin on 12/6/23.
//

import Foundation
import Combine

typealias WorldCityData = (name: String, timeZone: TimeZone)

final class WorldCityListViewModel {
    
    var cities = [WorldCityData]()
    
    func transform(viewDidLoad: AnyPublisher<Void, Never>) -> AnyPublisher<Void, Never> {
        return viewDidLoad.map { _ in
            self.getCityNames()
        }.eraseToAnyPublisher()
    }
    
    func transform(searchText: AnyPublisher<String, Never>) -> AnyPublisher<[WorldCityData], Never> {
        return searchText
            .throttle(for: 0.3, scheduler: DispatchQueue.main, latest: true)
            .map { text in
                return self.filterCities(text: text)
            }.eraseToAnyPublisher()
    }
    
    private func getCityNames() {
        var worldClickArray:[WorldCityData] = []
        
        for tz in TimeZone.knownTimeZoneIdentifiers{
            guard let timezone = TimeZone(identifier: tz) else {
                continue
            }
            
            guard var regionName = timezone.localizedName(for: .shortGeneric, locale: Locale(identifier:"ko-KR")) else {
                continue
            }
            
            var data = regionName.split(separator: " ")
            let _ = data.popLast()
            
            regionName = data.joined()
            
            worldClickArray.append((regionName, timezone))
        }
        
        worldClickArray.sort { lhs, rhs in
            lhs.0 < rhs.0
        }
        
        self.cities = worldClickArray
    }
    
    private func filterCities(text: String) -> [WorldCityData] {
        return self.cities.filter { city in
            city.0.contains(text)
        }
    }
}
