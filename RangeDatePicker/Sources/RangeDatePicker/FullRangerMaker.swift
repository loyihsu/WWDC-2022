//
//  FullRangeMaker.swift
//  
//
//  Created by Yu-Sung Loyi Hsu on 2022/6/8.
//

import Foundation

struct FullRangeMaker: Equatable {
    var start: Date?
    var end: Date?

    var isReset: Bool {
        start == nil && end == nil
    }

    var canMake: Bool {
        start != nil && end != nil
    }

    init(start: Date? = nil, end: Date? = nil) {
        self.start = start
        self.end = end
    }

    func form() -> [Date] {
        guard let min = self.start,
              let max = self.end,
              min != max else { return [] }
        var current = min, output = [Date]()
        while current <= max {
            output.append(current)
            current = current.addingTimeInterval(86_400)
        }
        return output
    }

    func formComponentSet(calendar: Calendar) -> Set<DateComponents> {
        Set(
            self.form()
                .compactMap {
                    calendar.dateComponents(in: .current, from: $0)
                }
        )
    }
}
