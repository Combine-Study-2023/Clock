//
//  NSObject+.swift
//  Clock-Combine
//
//  Created by sejin on 11/28/23.
//

import Foundation

extension NSObject {
    public static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    public var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
