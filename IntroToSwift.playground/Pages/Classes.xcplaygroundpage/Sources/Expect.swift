import Foundation

public func expect(assertion: Bool, message: String) -> String {
    if assertion {
        return "\(message) 👍"
    } else {
        return "\(message) 👎"
    }
}
