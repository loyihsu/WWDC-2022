# RangeDatePicker

This is a simple experimental project of creating a date picker that picks a range using the new `MultiDatePicker` API of SwiftUI 4 on iOS 16. Notice that this implementation is still in a very shaky state.

## Know Issues

* It is found that the `MultiDatePicker` does not faithfully report the date selection when a selection is made from setting the `@State`/`@Binding` variable. The value would not be updated when clicking within a selected range.
