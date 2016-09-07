import XCTest
import Nimble
import SwiftCoreExtensions

class String_ExtensionSpec: XCTestCase {
    func test_splitAll_splitsTheStringIntoComponentsSeparatedByTheGivenString() {
        let components = "t:h:i:s".splitAll(":")
        expect(components).to(equal(["t", "h", "i", "s"]))
    }
    
    func test_splitAll_whenTheGivenInputDoesNotAppear_returnsArrayContainingEntireString() {
        let components = "t:h:i:s".splitAll(",")
        expect(components).to(equal(["t:h:i:s"]))
    }
    
    func test_splitTimes_splitsTheStringUpToNTimes() {
        let components = "t:h:i:s".split(":", times: 2)
        expect(components).to(equal(["t", "h", "i:s"]))
    }
    
    func test_splitTimes_whenPassedNegativeValueForTimes_returnsArrayContainingEntireString() {
        let components = "t:h:i:s".split(":", times: -1)
        expect(components).to(equal(["t:h:i:s"]))
    }
    
    func test_splitTimes_whenPassedZeroForTimes_returnsArrayContainingEntireString() {
        let components = "t:h:i:s".split(":", times: 0)
        expect(components).to(equal(["t:h:i:s"]))
    }
    
    func test_splitTimes_whenPassedValueForTimesGreaterThanPossibleSplitComponentCount_splitsTheStringAsManyTimesAsItCan() {
        let components = "t:h:i:s".split(":", times: 1000)
        expect(components).to(equal(["t", "h", "i", "s"]))
    }
}
