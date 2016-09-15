import Foundation

extension NSDictionary {
    public func without(jsonPath: String) -> NSDictionary {
        let copy = self.mutableCopy() as! NSMutableDictionary

        let pathComponents = jsonPath.split(":", times: 1)
        if pathComponents.count == 1 {
            copy.removeObjectForKey(pathComponents[0])
        } else {
            let key = pathComponents[0]
            if let subdictionary = self[key] as? NSDictionary {
                copy.removeObjectForKey(key)
                let modifiedSubdictionary = subdictionary.without(pathComponents[1])
                copy.setValue(modifiedSubdictionary, forKey: key)
                return copy
            }
            if let array = self[key] as? [NSDictionary] {
                var modifiedArray = [NSDictionary]()
                let subcomponents = pathComponents[1].split(":", times: 1)
                let nextToken = subcomponents[0]
                if let nextTokenInt = Int(nextToken) {
                    for (i, dictionary) in array.enumerate() {
                        if nextTokenInt == i {
                            copy.removeObjectForKey(key)
                            let modifiedSubdictionary = dictionary.without(subcomponents[1])
                            modifiedArray.append(modifiedSubdictionary)
                        } else {
                            modifiedArray.append(dictionary)
                        }
                    }

                    copy.setValue(modifiedArray, forKey: key)
                    return copy
                } else {
                    for dictionary in array {
                        copy.removeObjectForKey(key)
                        let modifiedSubdictionary = dictionary.without(pathComponents[1])
                        modifiedArray.append(modifiedSubdictionary)
                    }

                    copy.setValue(modifiedArray, forKey: key)
                    return copy
                }
            }
        }

        return copy
    }
}

extension DictionaryLiteralConvertible {
    public func without(jsonPath: String) -> NSDictionary {
        return (self as! NSDictionary).without(jsonPath)
    }
}
