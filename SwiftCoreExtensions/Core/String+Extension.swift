import Foundation

extension String {
    public func splitAll(string: String) -> [String] {
        return self.componentsSeparatedByString(string)
    }
    
    public func split(string: String, times: Int) -> [String] {
        if times < 0 {
            return [self]
        }
        
        let allComponents = self.splitAll(string)
        if times >= allComponents.count {
            return allComponents
        }
        
        var components = [String]()
        for i in 0..<times {
            components.append(allComponents[i])
        }
        
        let numRemainingComponents = allComponents.count - times
        var finalComponent = allComponents[times]
        for i in (0..<(numRemainingComponents-1)).reverse() {
            finalComponent = finalComponent + string + allComponents[allComponents.count - i - 1]
        }
        
        components.append(finalComponent)
        return components
    }
}