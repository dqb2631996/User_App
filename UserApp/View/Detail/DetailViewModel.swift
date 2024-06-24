import Foundation

class DetailViewModel {
    var user: User?
    
    func updateUser(user: User) {
        self.user = user
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let isOnline = ConnectionManager.shared.hasConnectivity()
        if (isOnline) {
            fetchGitHubUser(completion: completion)
        }
    }
    
    func fetchGitHubUser( completion: @escaping () -> Void) {
        let urlString = "https://api.github.com/users/" + user!.login.description
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.user = try decoder.decode(User.self, from: data)
                    completion()
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
