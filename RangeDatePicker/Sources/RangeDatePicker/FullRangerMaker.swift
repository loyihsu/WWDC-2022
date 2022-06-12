//
//  FullRangeMaker.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/6/8.
//

import Foundation

struct FullRangeMaker {
    var isReset: Bool {
        if case .none = step {
            return true
        }
        return false
    }

    var canForm: Bool {
        if case .rangeSelected = step {
            return true
        }
        return false
    }

    init(max maxValue: Int? = nil) {
        maximum = maxValue
    }

    mutating func step(with calendar: Calendar, _ dates: Set<DateComponents>) {
        let selectedDate: DateComponents?

        let currentRange = form(with: calendar)
        let newDates = dates.filter { !currentRange.contains($0) }

        if newDates.count == 1, let first = newDates.first {
            selectedDate = first
        } else {
            selectedDate = nil
        }

        guard let selectedDate = selectedDate, let date = calendar.date(from: selectedDate) else {
            return
        }

        switch step {
        case .none:
            step = .startSelected(start: date)
        case let .startSelected(start: start):
            let min = min(start, date)
            let max = max(start, date)

            if let maximum {
                let maxValue = Double(maximum)
                let diffDays = max.timeIntervalSince(min) / 86400
                guard diffDays <= maxValue else { return }
            }

            step = .rangeSelected(start: min, end: max)
        case .rangeSelected:
            step = .startSelected(start: date)
        }
    }

    func form(with calendar: Calendar) -> Set<DateComponents> {
        switch step {
        case .none:
            return []
        case let .startSelected(start: date):
            let component = calendar.dateComponents(in: .current, from: date)
            return [component]
        case let .rangeSelected(start: start, end: end):
            let range = makeRange(min: start, max: end)
                .map {
                    calendar.dateComponents(in: .current, from: $0)
                }
            return Set(range)
        }
    }

    // MARK: - Private Helper

    private enum Step {
        case none
        case startSelected(start: Date)
        case rangeSelected(start: Date, end: Date)
    }

    private var step: Step = .none
    private var maximum: Int?

    private func makeRange(min: Date, max: Date) -> [Date] {
        var current = min, output = [Date]()
        while current <= max {
            output.append(current)
            current = current.addingTimeInterval(86400)
        }
        return output
    }
}
