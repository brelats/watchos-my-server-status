import Foundation

struct ServerChecker {
    static func checkStatus(of server: Server, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: server.url) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
}
