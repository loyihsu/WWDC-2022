extension Regex {
    public func matches(in string: String) throws -> [Match] {
        var processingString = string[string.startIndex ..< string.endIndex]
        var output: [Match] = []
        while let match = try firstMatch(in: processingString) {
            output.append(match)
            processingString = processingString[match.range.upperBound ..< processingString.endIndex]
        }
        return output
    }
}
