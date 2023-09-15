import Foundation

struct Server: Identifiable, Codable {
    var id = UUID()
    var name: String
    var url: String
    var environment: String
    var isOnline: Bool?
}
