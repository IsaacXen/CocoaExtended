import XCTest
@testable import CocoaExtended

final class CocoaExtendedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CocoaExtended().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
