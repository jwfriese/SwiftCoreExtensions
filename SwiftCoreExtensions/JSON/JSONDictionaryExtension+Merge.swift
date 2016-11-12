import Foundation

extension NSDictionary {
    public func merge(_ otherDictionary: NSDictionary, overwriteCollisions: Bool = true) throws -> NSDictionary {
        let copy = self.mutableCopy() as! NSMutableDictionary
        for key in otherDictionary.allKeys {
            guard let jsonKey = key as? String else { throw KeyIsNotAStringError(offendingKeyObject: key as AnyObject) }
            let keyExists = self.value(forKey: jsonKey) != nil
            let shouldOverwriteValue = overwriteCollisions || !keyExists
            if shouldOverwriteValue {
                copy.setValue(otherDictionary[jsonKey], forKey: jsonKey)
            }
        }

        return copy
    }
}

extension ExpressibleByDictionaryLiteral {
    public func merge(_ otherDictionary: NSDictionary, overwriteCollisions: Bool = true) throws -> NSDictionary {
        return try (self as! NSDictionary).merge(otherDictionary, overwriteCollisions: overwriteCollisions)
    }
}
