import XCTest
import Nimble

class JSONDictionaryExtension_WithoutSpec: XCTestCase {
    func test_without_whenDictionaryHasKey_returnsADictionaryWithTheGivenKeyEntryRemoved() {
        let originalJSON: Dictionary<String, AnyObject> = ["key" : "value"]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("key")

        expect(modifiedDictionary["key"]).to(beNil())
    }

    func test_without_whenDictionaryHasKeyPathMatchingInput_returnsADictionaryWithTheGivenKeyPathEntryRemoved() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("nestingKey:string")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0
            ]
        ]))
    }

    func test_without_whenDictionaryDoesNotHaveKeyPathMatchingInput_returnsACopyOfTheDictionary() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("turtle:string")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]))
    }

    func test_without_whenAKeyPathComponentMapsToArrayOfDictionaries_returnsADictionaryWithAllInstancesOfTheKeyRemovedFromTheSubdictionaries() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [
                        "anotherKey" : "anotherValue"
                    ],
                    [
                        "anotherKey" : "anotherValue"
                    ]
                ]
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("nestingKey:array:anotherKey")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [:],
                    [:]
                ]
            ]
        ]))
    }

    func test_without_whenAKeyPathComponentMapsToArrayOfDictionaries_whenTheFollowingComponentIsANumber_returnsADictionaryWithTheKeyRemovedFromTheSubdictionaryAtThatIndexInTheArray() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [
                        "anotherKey" : "anotherValue"
                    ],
                    [
                        "anotherKey" : "anotherValue"
                    ]
                ]
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("nestingKey:array:1:anotherKey")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [
                        "anotherKey" : "anotherValue"
                    ],
                    [:]
                ]
            ]
        ]))
    }

    func test_without_whenAKeyPathComponentMapsToArrayOfDictionaries_whenTheFollowingComponentIsANumber_whenThatNumberIsNegative_returnsACopyOfTheDictionary() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [
                        "anotherKey" : "anotherValue"
                    ],
                    [
                        "anotherKey" : "anotherValue"
                    ]
                ]
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("nestingKey:array:-1:anotherKey")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [
                        "anotherKey" : "anotherValue"
                    ],
                    [
                        "anotherKey" : "anotherValue"
                    ]
                ]
            ]
        ]))
    }

    func test_without_whenAKeyPathComponentMapsToArrayOfDictionaries_whenTheFollowingComponentIsANumber_whenThatNumberIsLargerThanTheArray_returnsACopyOfTheDictionary() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [
                        "anotherKey" : "anotherValue"
                    ],
                    [
                        "anotherKey" : "anotherValue"
                    ]
                ]
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("nestingKey:array:100:anotherKey")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "array" : [
                    [
                        "anotherKey" : "anotherValue"
                    ],
                    [
                        "anotherKey" : "anotherValue"
                    ]
                ]
            ]
            ]))
    }

    func test_without_canBeUsedDirectlyOnSwiftDictionary() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]
        let modifiedDictionary = originalJSON.without("nestingKey:string")
        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0
            ]
        ]))
    }

    func test_without_whenInvalidKeyPathContainingTrailingSeparator_returnsACopyOfTheDictionary() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("nestingKey:string:")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]))
    }

    func test_without_whenInvalidKeyPathContainingLeadingSeparator_returnsACopyOfTheDictionary() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without(":nestingKey:string")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]))
    }

    func test_without_whenInvalidKeyPathContainingMultipleConsecutiveSeparators_returnsACopyOfTheDictionary() {
        let originalJSON: Dictionary<String, AnyObject> = [
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]
        let originalJSONDictionary: NSDictionary = originalJSON
        let modifiedDictionary = originalJSONDictionary.without("nestingKey::string")

        expect(modifiedDictionary).to(equal([
            "key" : "value",
            "nestingKey" : [
                "number" : 0,
                "string" : "string"
            ]
        ]))
    }
}
