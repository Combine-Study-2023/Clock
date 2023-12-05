//
//  Stopwatch.swift
//  Clock-Combine
//
//  Created by yeonsu on 12/4/23.
//

import Foundation

class Stopwatch: NSObject {
  var counter: Double   // 초 경과 시간 추적
  var timer: Timer      // 특정 간격마다 지정된 동작을 반복하거나 실행
  
  override init() {
    counter = 0.0
    timer = Timer()
  }
}
