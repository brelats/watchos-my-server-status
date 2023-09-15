import SwiftUI

struct ContentView: View {
    @State private var servers: [Server] = []
    @State private var showAddServerView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(servers.enumerated()), id: \.element.id) { index, server in
                    
                        VStack(alignment: .leading){
                            HStack {
                                Text(server.name)
                                Spacer()
                                if let isOnline = server.isOnline {
                                    Image(systemName: isOnline ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(isOnline ? .green : .red)
                                }
                            }
                            Text(server.environment).foregroundColor(Color.gray)
                        }
                    
                }

                .onDelete(perform: deleteServer)
                
                Button(action: { showAddServerView.toggle() }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Server")
                    }
                }
            }
            .navigationTitle("Servers")
            .sheet(isPresented: $showAddServerView) {
                AddServerView(servers: $servers, isPresented: $showAddServerView)
            }
        }
        .onAppear {
            if let loadedServers = ServerStorage.load() {
                self.servers = loadedServers
            }
            
            for index in servers.indices {
                ServerChecker.checkStatus(of: servers[index]) { isOnline in
                    servers[index].isOnline = isOnline
                }
            }
        }
    }

    func deleteServer(at offsets: IndexSet) {
        servers.remove(atOffsets: offsets)
        ServerStorage.save(servers)
    }
}
