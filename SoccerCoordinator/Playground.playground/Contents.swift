import Cocoa

// Initialize player's data storage
var players = [
    ["name": "Joe Smith", "height": "42", "playedb4" : "YES",	"guardian" : "Jim and Jan Smith"],
    ["name": "Jill Tanner", "height" : "36", "playedb4" : "YES",	"guardian" : "Clara Tanner"],
    ["name": "Bill Bon", "height" : "43", "playedb4" : "YES",	"guardian" : "Sara and Jenny Bon"],
    ["name": "Eva Gordon", "height" : "45", "playedb4" : "NO", "guardian" : "Wendy and Mike Gordon"],
    ["name": "Matt Gill", "height": "40", "playedb4": "NO",	"guardian": "Charles and Sylvia Gill"],
    ["name": "Kimmy Stein", "height": "41", "playedb4": "NO",	"guardian": "Bill and Hillary Stein"],
    ["name": "Sammy Adams", "height": "45", "playedb4": "NO",	"guardian": "Jeff Adams"],
    ["name": "Karl Saygan", "height": "42", "playedb4": "YES",	"guardian": "Heather Bledsoe"],
    ["name": "Suzane Greenberg", "height": "44", "playedb4": "YES",	"guardian": "Henrietta Dumas"],
    ["name": "Sal Dali", "height": "41", "playedb4": "NO",	"guardian": "Gala Dali"],
    ["name": "Joe Kavalier", "height": "39", "playedb4": "NO",	"guardian": "Sam and Elaine Kavalier"],
    ["name": "Ben Finkelstein", "height": "44", "playedb4": "NO",	"guardian": "Aaron and Jill Finkelstein"],
    ["name": "Diego Soto", "height": "41", "playedb4": "YES",	"guardian": "Robin and Sarika Soto"],
    ["name": "Chloe Alaska", "height": "47", "playedb4": "NO",	"guardian": "David and Jamie Alaska"],
    ["name": "Arnold Willis", "height": "43", "playedb4": "NO",	"guardian": "Claire Willis"],
    ["name":"Phillip Helm", "height": "44", "playedb4": "YES",	"guardian": "Thomas Helm and Eva Jones"],
    ["name": "Les Clay", "height": "42", "playedb4": "YES",	"guardian": "Wynonna Brown"],
    ["name": "Herschel Krustofski","height":  "45", "playedb4": "YES", "guardian": "Hyman and Rachel Krustofski"]
]


// Intialize three evenly matched teams
typealias Team = [String : Any]
typealias Player = [String : String]
var teamSharks : Team = ["name": "teamSharks", "players": NSMutableArray()],
teamDragons : Team = ["name": "teamDragons", "players": NSMutableArray()],
teamRaptors : Team = ["name": "teamRaptors", "players": NSMutableArray()]


// Divide players into two group, experienced group and inexperienced group
var experiencedPlayers = [Player]()
var inexperiencedPlayers = [Player]()

for player in players {
    if player["playedb4"] == "YES" {
        experiencedPlayers += [player]
    } else {
        inexperiencedPlayers += [player]
    }
}


// Sort players by height, with two groups inverted to each other
experiencedPlayers.sort{ Int($0["height"]!)! < Int($1["height"]!)! }
inexperiencedPlayers.sort{  Int($0["height"]!)! > Int($1["height"]!)! }


// Pairing every two players as a partner
var partners = [[Player]]()
for i in 0..<players.count / 2 {
    partners += [[experiencedPlayers[i], inexperiencedPlayers[i]]]
}


// Divide partners into three evenly distributed teams
for j in 1...3 {
    var currentTeam = NSMutableArray()
    switch j {
    case 1:
        currentTeam = teamSharks["players"] as! NSMutableArray
    case 2:
        currentTeam = teamDragons["players"] as! NSMutableArray
    case 3:
        currentTeam = teamRaptors["players"] as! NSMutableArray
    default: break
    }
    
    for i in stride(from: j, through: (players.count / 2), by: 3) {
        currentTeam.add( partners[i - 1] )
    }
}

// Create a teams variable that contains all three teams
var teams = [teamRaptors, teamDragons, teamSharks]

/**
 Calculate the average height of a specified team
 */
func averageHeight(forTeam team: Team) -> Int {
    
    var accumulatedHeight = 0
    var memberCount = 0
    for partner in team["players"] as!  [[Player]] {
        for player in partner {
            memberCount += 1
            accumulatedHeight += Int(player["height"]!)!
        }
    }
    
    return accumulatedHeight / memberCount
}


/**!
 Prints letter to parents of a specified team
 */
func letter(for team: Team) -> [String] {
    
    var output = [String]()
    var practiceTime = ""
    switch team["name"] as! String {
    case "teamSharks":
        practiceTime = "March 17, 3pm"
    case "teamDragons":
        practiceTime = "March 17, 1pm"
    case "teamRaptors":
        practiceTime = "March 18, 1pm"
    default:
        practiceTime = "Not on schedule"
    }
    
    for partner in team["players"] as! [[Player]] {
        
        if partner.count > 1 {
            for player in partner {
                if let guardian = player["guardian"],
                    let playerName = player["name"],
                    let teamName = team["name"] {
                    output += ["Greetings \(guardian), \n" +
                        "\(playerName) is placed into \(teamName) in the up coming Soccer League Game, \n" +
                        "average player height for team: \(averageHeight(forTeam: team)) inch\n" +
                        "Be sure to come for team practice at \(practiceTime)\n" +
                        "-Soccer League Coordinator\n"]
                }
            }
        }
    }
    return output
}


// A letter for guardians of players in each team
let lettersForTeamDragons = letter(for: teamDragons)
let lettersForTeamSharks = letter(for: teamSharks)
let lettersForTeamRaptors = letter(for: teamRaptors)

for letter in lettersForTeamDragons + lettersForTeamSharks + lettersForTeamRaptors {
    
    print(letter)
}
