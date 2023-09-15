import SwiftUI

struct ServerRow: View {
    let server: Server

    var body: some View {
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
}
