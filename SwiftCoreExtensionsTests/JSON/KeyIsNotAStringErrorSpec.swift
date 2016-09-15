import XCTest
import Nimble
@testable import SwiftCoreExtensions

class KeyIsNotAStringErrorSpec: XCTestCase {
    func test_description_whenTypeIsKeyIsNotString_returnsDescriptiveMessage() {
        let notAJSONKey = 1
        let error = KeyIsNotAStringError(offendingKeyObject: notAJSONKey)
        expect(error.description).to(equal("Key is not a string (type: __NSCFNumber)"))
    }
}
