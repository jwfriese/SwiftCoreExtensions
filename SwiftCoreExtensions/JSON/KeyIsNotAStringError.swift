struct KeyIsNotAStringError: Error {
    fileprivate var offendingKeyObject: AnyObject

    init(offendingKeyObject: AnyObject) {
        self.offendingKeyObject = offendingKeyObject
    }
}

extension KeyIsNotAStringError: CustomStringConvertible {
    var description: String {
        get {
            return "Key is not a string (type: \(String(describing: type(of: offendingKeyObject))))"
        }
    }
}
