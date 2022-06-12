import RegexBuilder
@testable import RegexMatches
import XCTest

final class RegexMatchesTests: XCTestCase {
    func testNoMatch() throws {
        let testInput = "I want to match this - "
        let regex = Regex {
            Capture {
                "*"
                OneOrMore(CharacterClass(.whitespace, .any), .reluctant)
                "*"
            }
        }
        let matches = try regex.matches(in: testInput)
        XCTAssertEqual(matches.count, 0)
    }

    func testOneMatch() throws {
        let testInput = "I want to match this - *italic* text"
        let regex = Regex {
            Capture {
                "*"
                OneOrMore(CharacterClass(.whitespace, .any), .reluctant)
                "*"
            }
        }
        let matches = try regex.matches(in: testInput)
        XCTAssertEqual(matches.count, 1)
        XCTAssertEqual(matches[0].1, "*italic*")
    }

    func testMultiMatch() throws {
        let testInput = "I want to match this - *italic text* as *I love to eat pasta*"
        let regex = Regex {
            Capture {
                "*"
                OneOrMore(CharacterClass(.whitespace, .any), .reluctant)
                "*"
            }
        }
        let matches = try regex.matches(in: testInput)
        XCTAssertEqual(matches.count, 2)
        XCTAssertEqual(matches[0].1, "*italic text*")
        XCTAssertEqual(matches[1].1, "*I love to eat pasta*")
    }

    func testMutlipleSingleCharacterMatch() throws {
        let testInput = "I want to match this - **********"
        let regex = Regex {
            Capture {
                "*"
            }
        }

        let matches = try regex.matches(in: testInput)
        XCTAssertEqual(matches.count, 10)
        XCTAssertEqual(matches[0].1, "*")
        XCTAssertEqual(matches[1].1, "*")
        XCTAssertEqual(matches[2].1, "*")
        XCTAssertEqual(matches[3].1, "*")
        XCTAssertEqual(matches[4].1, "*")
        XCTAssertEqual(matches[5].1, "*")
        XCTAssertEqual(matches[6].1, "*")
        XCTAssertEqual(matches[7].1, "*")
        XCTAssertEqual(matches[8].1, "*")
        XCTAssertEqual(matches[9].1, "*")
    }
}
