import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var table: WKInterfaceTable!
    var servers: [Server] = []

    override func willActivate() {
        super.willActivate()
        loadServers()
    }

    func loadServers() {
        if let savedServers = UserDefaults.standard.data(forKey: "servers"),
           let loadedServers = try? JSONDecoder().decode([Server].self, from: savedServers) {
            servers = loadedServers
        }
        
        table.setNumberOfRows(servers.count, withRowType: "ServerRow")
        for (index, server) in servers.enumerated() {
            if let rowController = table.rowController(at: index) as? ServerRowController {
                rowController.serverName.setText(server.name)
                rowController.serverStatus.setText("Checking...")
                
                checkServerStatus(url: server.url) { online in
                    rowController.serverStatus.setText(online ? "Online" : "Offline")
                }
            }
        }
    }
    
    func checkServerStatus(url: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "HEAD"
        let task = URLSession.shared.dataTask(with: request) { (_, response, _) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
}
