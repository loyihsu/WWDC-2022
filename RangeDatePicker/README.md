# RangeDatePicker

This is a simple experimental project of creating a date picker that picks a range using the new `MultiDatePicker` API of SwiftUI 4. Notice that this implementation is still in a very shaky state.

## Know Issues

* It is found that the `MultiDatePicker` does not faithfully report the date selection when a selection is made from setting the `@State`/`@Binding` variable. The value would not be updated when clicking within a selected range.
* Binding getter is not called when the underlying code is called. Therefore, the range maker shows the proper range, while the UI does not reflect the range.
