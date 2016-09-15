import XCTest
import Nimble
@testable import SwiftCoreExtensions

class JSONDictionaryExtension_MergeSpec: XCTestCase {
    func test_merge_whenNoCollisions_returnsDictionaryWithAllKeyValuePairsFromBothInputs() {
        let dictionaryOne = [
            "turtle_power" : "oh yeah",
            "crab_power" : 1
        ]

        let dictionaryTwo = [
            "cool_song" : "Kiss From a Rose"
        ]

        let result = try! dictionaryOne.merge(dictionaryTwo)
        expect(result["turtle_power"] as? String).to(equal("oh yeah"))
        expect(result["crab_power"] as? Int).to(equal(1))
        expect(result["cool_song"] as? String).to(equal("Kiss From a Rose"))
    }

    func test_merge_whenNoCollisions_whenADictionaryIsNotJSON_throwsAnError() {
        let dictionaryOne = [
            "turtle_power" : "oh yeah",
            "crab_power" : 1
        ]

        let notJSONDictionary = [
            NSData() : "Kiss From a Rose"
        ]

        expect { try dictionaryOne.merge(notJSONDictionary) }.to(throwError() { error in
            guard let notAStringError = error as? KeyIsNotAStringError else {
                fail("Failed to throw KeyIsNotAStringError")
                return
            }

            expect(notAStringError.description).to(equal("Key is not a string (type: _NSZeroData)"))
        })
    }

    func test_merge_whenCollisions_whenNoValuePassedForOverwriteParam_overwritesCollidingKeyValues() {
        let dictionaryOne = [
            "turtle_power" : "oh yeah",
            "crab_power" : 1
        ]

        let dictionaryTwo = [
            "cool_song" : "Kiss From a Rose",
            "crab_power" : "new value"
        ]

        let result = try! dictionaryOne.merge(dictionaryTwo)
        expect(result["turtle_power"] as? String).to(equal("oh yeah"))
        expect(result["cool_song"] as? String).to(equal("Kiss From a Rose"))
        expect(result["crab_power"] as? String).to(equal("new value"))
    }

    func test_merge_whenCollisions_whenTruePassedForOverwriteParam_overwritesCollidingKeyValues() {
        let dictionaryOne = [
            "turtle_power" : "oh yeah",
            "crab_power" : 1
        ]

        let dictionaryTwo = [
            "cool_song" : "Kiss From a Rose",
            "crab_power" : "new value"
        ]

        let result = try! dictionaryOne.merge(dictionaryTwo, overwriteCollisions: true)
        expect(result["turtle_power"] as? String).to(equal("oh yeah"))
        expect(result["cool_song"] as? String).to(equal("Kiss From a Rose"))
        expect(result["crab_power"] as? String).to(equal("new value"))
    }

    func test_merge_whenCollisions_whenFalsePassedForOverwriteParam_doesNotOverwriteCollidingKeyValues() {
        let dictionaryOne = [
            "turtle_power" : "oh yeah",
            "crab_power" : 1
        ]

        let dictionaryTwo = [
            "cool_song" : "Kiss From a Rose",
            "crab_power" : "new value"
        ]

        let result = try! dictionaryOne.merge(dictionaryTwo, overwriteCollisions: false)
        expect(result["turtle_power"] as? String).to(equal("oh yeah"))
        expect(result["cool_song"] as? String).to(equal("Kiss From a Rose"))
        expect(result["crab_power"] as? Int).to(equal(1))
    }
}
