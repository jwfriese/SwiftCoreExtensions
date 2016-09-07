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
                
                for dictionary in array {
                    copy.removeObjectForKey(key)
                    let modifiedSubdictionary = dictionary.without(pathComponents[1])
                    modifiedArray.append(modifiedSubdictionary)
                }
                
                copy.setValue(modifiedArray, forKey: key)
                return copy
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