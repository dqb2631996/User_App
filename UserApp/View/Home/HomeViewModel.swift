import Foundation
import UIKit

class HomeViewModel {
    var users: [User] = []
    var onDataUpdate: (() -> Void)?
    var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData() {
        let isOnline = ConnectionManager.shared.hasConnectivity()
        if (isOnline) {
            fetchGitHubUsers()
        } else if let users = DataFileManager.shared.loadGitHubUsers(){
            self.users = users;
            self.onDataUpdate?();
        }
    }
       
    func fetchGitHubUsers() {
        
        let urlString = "https://api.github.com/users"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.users = try decoder.decode([User].self, from: data)
                    DataFileManager.shared.saveGitHubUsers(users: self.users)
                    DispatchQueue.main.async {
                        self.onDataUpdate?()
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
