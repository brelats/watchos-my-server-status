import WatchKit
import Foundation

class AddServerInterfaceController: WKInterfaceController {
    @IBOutlet weak var nameField: WKInterfaceTextField!
    @IBOutlet weak var urlField: WKInterfaceTextField!
    @IBOutlet weak var environmentPicker: WKInterfacePicker!
    
    let environments = ["Production", "Staging"]
    
    @IBAction func saveServer() {
        let selectedEnvironment = environments[environmentPicker.selectedItemIndex]
        let newServer = Server(name: nameField.text ?? "", url: urlField.text ?? "", environment: selectedEnvironment)
        
        var savedServers: [Server] = []
        if let savedData = UserDefaults.standard.data(forKey: "servers"),
           let loadedServers = try? JSONDecoder().decode([Server].self, from: savedData) {
            savedServers = loadedServers
        }
        
        savedServers.append(newServer)
        if let savedData = try? JSONEncoder().encode(savedServers) {
            UserDefaults.standard.set(savedData, forKey: "servers")
        }
        
        // Volver a la vista de lista
        pop()
    }
}
