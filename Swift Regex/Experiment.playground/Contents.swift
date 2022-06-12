import Foundation
import RegexBuilder

let someMarkdownText = """
# Hello World

## World news

I want to **parse** some very *interest* looking _markdown_ syntax. <u>Did I mention I want HTML too?</u>
"""

// Regex literals
let word = /\w+/
try word.firstMatch(in: someMarkdownText)

// Run time construction
let rule = #"\w+"#
try Regex(rule).firstMatch(in: someMarkdownText)

// Regex builders
let builder = Regex {
    OneOrMore(.word)
}
try builder.firstMatch(in: someMarkdownText)

let markdownHeaderRegex = Regex {
    Capture { OneOrMore(/#/) }  // Markdown header syntax
    OneOrMore(" ")
    Capture {
        OneOrMore {
            CharacterClass.any
        }
    }
}

try markdownHeaderRegex.firstMatch(in: someMarkdownText)
