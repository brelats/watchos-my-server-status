import SwiftUI

struct AddServerView: View {
    @Binding var servers: [Server]
    @Binding var isPresented: Bool
    @State private var name = ""
    @State private var url = ""
    @State private var environment = "Production"
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("URL", text: $url)
            Picker("Environment", selection: $environment) {
                Text("Production").tag("Production")
                Text("Staging").tag("Staging")
            }
            Button("Save server") {
                let newServer = Server(name: name, url: url, environment: environment)
                servers.append(newServer)
                ServerStorage.save(servers)
                isPresented = false
            }
        }
    }
}
