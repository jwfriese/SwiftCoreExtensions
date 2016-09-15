struct KeyIsNotAStringError: ErrorType {
    private var offendingKeyObject: AnyObject

    init(offendingKeyObject: AnyObject) {
        self.offendingKeyObject = offendingKeyObject
    }
}

extension KeyIsNotAStringError: CustomStringConvertible {
    var description: String {
        get {
            return "Key is not a string (type: \(String(offendingKeyObject.dynamicType)))"
        }
    }
}
