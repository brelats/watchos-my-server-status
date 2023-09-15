import SwiftUI

struct EditServerView: View {
    @Binding var servers: [Server]
    let serverIndex: Int
    
    @State private var editedServer: Server
    
    init(servers: Binding<[Server]>, serverIndex: Int) {
        _servers = servers
        self.serverIndex = serverIndex
        _editedServer = State(initialValue: servers.wrappedValue[serverIndex])
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $editedServer.name)
            TextField("URL", text: $editedServer.url)
            Picker("Environment", selection: $editedServer.environment) {
                Text("Production").tag("Production")
                Text("Staging").tag("Staging")
            }
            Button("Save") {
                servers[serverIndex] = editedServer
                ServerStorage.save(servers)
            }
        }
    }
}
