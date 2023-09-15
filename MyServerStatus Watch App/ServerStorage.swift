import Foundation

struct ServerStorage {
    static func save(_ servers: [Server]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(servers) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedServers")
        }
    }

    static func load() -> [Server]? {
        let defaults = UserDefaults.standard
        if let savedServers = defaults.object(forKey: "SavedServers") as? Data {
            let decoder = JSONDecoder()
            if let loadedServers = try? decoder.decode([Server].self, from: savedServers) {
                return loadedServers
            }
        }
        return nil
    }
}
