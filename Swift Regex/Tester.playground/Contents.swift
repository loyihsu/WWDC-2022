import Foundation
import RegexBuilder

let rawInput = """
CREDIT    04062020    PayPal transfer    $4.99
CREDIT    04032020    Payroll            $69.73
DEBIT     04022020    ACH transfer       $38.25
DEBIT     03242020    IRS tax payment    $52249.98
"""

struct Entry {
    let type: EntryType
    let date: Date
    let title: String
    let price: Double

    enum EntryType: String {
        case credit = "CREDIT", debit = "DEBIT"
    }
}

let regex = Regex {
    TryCapture {
        ChoiceOf {
            "CREDIT"
            "DEBIT"
        }
    } transform: { substring -> Entry.EntryType? in
        Entry.EntryType(rawValue: String(substring))
    }
    OneOrMore(.whitespace)
    TryCapture {
        Repeat(.digit, count: 2)
        Repeat(.digit, count: 2)
        Repeat(.digit, count: 4)
    } transform: { substring -> Date? in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        return dateFormatter.date(from: String(substring))
    }
    OneOrMore(.whitespace)
    Capture {
        OneOrMore {
            CharacterClass(.word, .whitespace)
        }
        CharacterClass.word
    } transform: { substring -> String in
        String(substring)
    }
    OneOrMore(.whitespace)
    "$"
    TryCapture {
        OneOrMore(.digit)
        "."
        Repeat(.digit, count: 2)
    } transform: { substring -> Double? in
        Double(String(substring))
    }
}

rawInput
    .components(separatedBy: .newlines)
    .compactMap {
        try? regex.firstMatch(in: $0)
    }
    .map {
        Entry(
            type: $0.output.1,
            date: $0.output.2,
            title: $0.output.3,
            price: $0.output.4
        )
    }
