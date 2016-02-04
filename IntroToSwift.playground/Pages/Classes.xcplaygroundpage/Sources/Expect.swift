import Foundation

public func expect(assertion: Bool) -> String {
    if assertion {
        return "Good work!"
    } else {
        return "Still not right!"
    }
}
