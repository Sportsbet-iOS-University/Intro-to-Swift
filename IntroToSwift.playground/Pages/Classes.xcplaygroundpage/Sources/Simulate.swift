import Foundation

public class ForceUser {
    public var hitPoints = 0
    public var name = "Unnamed"
    public var chosenLightsaberColor: LightsaberColor = .Blue
    
    public init() {
        
    }
    
    public enum Side: String {
        case Light, Dark
    }
    
    public enum LightsaberColor: String {
        case Blue, Green, Purple, Red
    }
    
    public func side() -> Side {
        return .Light
    }
    
    public func lightsaberColours() -> [LightsaberColor] {
        return []
    }
    
    public func fight(other: ForceUser) -> String {
        return ""
    }
}

public func simulate(users: [ForceUser]) -> [String] {
    let luke = users[0], obiwan = users[1], darthvader = users[2],
        darthmaul = users[3]
    
    var results = [String]()
    let jediCols: [ForceUser.LightsaberColor] = [
        .Blue, .Green, .Purple
    ]
    
    results.append(expect(darthvader.chosenLightsaberColor == .Red))
    results.append(expect(darthmaul.chosenLightsaberColor == .Red))
    results.append(expect(jediCols.contains(luke.chosenLightsaberColor)))
    results.append(expect(jediCols.contains(obiwan.chosenLightsaberColor)))
    
    results.append(expect(luke.fight(obiwan) == "Fight refused."))
    results.append(expect(darthvader.fight(darthmaul) == "Darth Vader " +
        "Darth Maul with Red lightsaber! Darth Vader wins!"))
    results.append(expect(darthmaul.hitPoints <= 0))
    results.append(expect(darthvader.hitPoints == 14))
    results.append(expect(obiwan.fight(darthvader) == "Obi-Wan Kenobi fights" + "Darth Vader with " + obiwan.chosenLightsaberColor.rawValue +
        " lightsaber! Darth Vader wins!"))
    results.append(expect(obiwan.hitPoints <= 0))
    results.append(expect(darthvader.hitPoints == 6))
    results.append(expect(luke.fight(darthvader) == "Luke Skywalker fights " + "Darth Vader with " + luke.chosenLightsaberColor.rawValue +
        " lightsaber! Luke Skywalker wins!"))
    results.append(expect(darthvader.hitPoints <= 0))
    results.append(expect(luke.hitPoints == 4))
    expect(luke.fight(darthvader) == "Nothing happens.")
    return results
}
