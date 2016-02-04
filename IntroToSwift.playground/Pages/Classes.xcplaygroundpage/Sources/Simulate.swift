import Foundation

public class ForceUser {
    public var hitPoints = 0
    public var name = "Unnamed"
    public var chosenLightsaberColor: LightsaberColor = .SpaceGray
    
    public init() {
        
    }
    
    public enum Side: String {
        case Light, Dark
    }
    
    public enum LightsaberColor: String {
        case Blue, Green, Purple, Red, SpaceGray
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
    
    results.append(expect(darthvader.chosenLightsaberColor == .Red,
        message: "Darth Vader's lightsaber is red?"))
    results.append(expect(darthmaul.chosenLightsaberColor == .Red,
        message: "Darth Maul's lightsaber is red?"))
    results.append(expect(jediCols.contains(luke.chosenLightsaberColor),
        message: "Luke's lightsaber is blue|green|purple?"))
    results.append(expect(jediCols.contains(obiwan.chosenLightsaberColor),
        message: "Obi-wan's lightsaber is blue|green|purple?"))
    
    results.append(expect(luke.fight(obiwan) == "Fight refused.",
        message: "Luke refuses to fight Obi-wan"))
    results.append(expect(darthvader.fight(darthmaul) == "Darth Vader " +
        "fights Darth Maul with Red lightsaber! Darth Vader wins!",
        message: "Darth Vader beats Darth Maul?"))
    results.append(expect(darthmaul.hitPoints <= 0,
        message: "Darth Maul is dead?"))
    results.append(expect(darthvader.hitPoints == 14,
        message: "Darth Vader recovered HP?"))
    results.append(expect(obiwan.fight(darthvader) == "Obi-Wan Kenobi fights " + "Darth Vader with " + obiwan.chosenLightsaberColor.rawValue +
        " lightsaber! Darth Vader wins!",
        message: "Darth Vader beats Obi-Wan?"))
    results.append(expect(obiwan.hitPoints <= 0,
        message: "Obi-wan is dead?"))
    results.append(expect(darthvader.hitPoints == 6,
        message: "Darth Vader lost HP?"))
    results.append(expect(luke.fight(darthvader) == "Luke Skywalker fights " + "Darth Vader with " + luke.chosenLightsaberColor.rawValue +
        " lightsaber! Luke Skywalker wins!",
        message: "Luke beats Darth Vader?"))
    results.append(expect(darthvader.hitPoints <= 0,
        message: "Darth Vader is dead?"))
    results.append(expect(luke.hitPoints == 4,
        message: "Luke lost HP?"))
    expect(luke.fight(darthvader) == "Nothing happens.",
        message: "Can't fight the dead?")
    return results
}
