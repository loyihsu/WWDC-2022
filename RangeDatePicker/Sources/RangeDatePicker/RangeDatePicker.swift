import SwiftUI

public struct RangeDatePicker: View {
    var titleKey: LocalizedStringKey

    @Binding var selectedDates: Set<DateComponents>
    @Environment(\.calendar) var calendar

    @State private var fullRange = FullRangeMaker()

    public init(_ titleKey: LocalizedStringKey, selectedDates: Binding<Set<DateComponents>>) {
        self.titleKey = titleKey
        self._selectedDates = selectedDates
    }

    public var body: some View {
        MultiDatePicker(titleKey, selection: $selectedDates)
            .onChange(of: selectedDates) { selected in
                guard fullRange.start == nil || fullRange.end == nil else {
                    if selectedDates != fullRange.formComponentSet(calendar: calendar) {
                        selectedDates = []
                    }
                    fullRange = FullRangeMaker()
                    return
                }

                if fullRange.isReset && selectedDates.count > 1 {
                    selectedDates = []
                    return
                }

                let dates = selected.compactMap { calendar.date(from: $0) }

                guard let min = dates.min(),
                      let max = dates.max() else { return }

                if min != max {
                    fullRange = FullRangeMaker(start: min, end: max)
                } else {
                    fullRange = FullRangeMaker(start: min)
                }
            }
            .onChange(of: fullRange) { newRange in
                guard fullRange.canMake else { return }
                selectedDates = fullRange.formComponentSet(calendar: calendar)
            }
    }
}
