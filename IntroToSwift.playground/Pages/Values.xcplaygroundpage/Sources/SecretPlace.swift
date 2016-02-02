import Foundation

public protocol NSASpyable {
    var personalInformation: String { get }
    
    func sendInfoToNSA()
}

public func beginPRISMProgram(objects: [NSASpyable]) {
    print("Collected \(objects.count) juicy bits of personal info!")
    for spyable in objects {
        print("\(spyable.personalInformation)")
    }
}
