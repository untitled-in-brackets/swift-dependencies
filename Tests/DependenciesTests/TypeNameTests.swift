import XCTest

@testable import Dependencies

final class TypeNameTests: XCTestCase {
  func testSanitizesUnknownContext() {
    struct LocalType {}

    XCTAssertFalse(typeName(LocalType.self).contains("(unknown context at $"))
  }
}
