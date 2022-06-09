import SwiftUI

public struct RangeDatePicker: View {
    var titleKey: LocalizedStringKey

    @Binding var selectedDates: Set<DateComponents>
    @Environment(\.calendar) var calendar

    @State private var rangeMaker = FullRangeMaker()

    public init(_ titleKey: LocalizedStringKey, selectedDates: Binding<Set<DateComponents>>) {
        self.titleKey = titleKey
        self._selectedDates = selectedDates
    }

    public var body: some View {
        MultiDatePicker(titleKey, selection: bindSelectedDates())
    }

    private func bindSelectedDates() -> Binding<Set<DateComponents>> {
        return Binding<Set<DateComponents>>(
            get: {
                let newRange = rangeMaker.form(with: calendar)
                DispatchQueue.main.async {
                    self.selectedDates = newRange
                }
                return newRange
            },
            set: { newSelection in
                rangeMaker.step(with: calendar, newSelection)
            }
        )
    }
}
