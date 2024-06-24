import Foundation

class DataFileManager {
    
    static let shared = DataFileManager()
    
    private init() {}
    
    // Đường dẫn tới file trong thư mục Documents
    private var fileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsURL.appendingPathComponent("githubUsers.json")
    }
    
    // Lưu dữ liệu vào file
    func saveGitHubUsers(users: [User]) {
        guard let fileURL = self.fileURL else {
            print("Could not find file URL")
            return
        }
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(users)
            try data.write(to: fileURL, options: .atomic)
            print("Data saved to file: \(fileURL.absoluteString)")
        } catch {
            print("Error saving data to file: \(error.localizedDescription)")
        }
    }
    
    // Đọc dữ liệu từ file
    func loadGitHubUsers() -> [User]? {
        guard let fileURL = self.fileURL else {
            print("Could not find file URL")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: data)
            print("Data loaded from file: \(fileURL.absoluteString)")
            return users
        } catch {
            print("Error loading data from file:                    \(error.localizedDescription)")
            return nil
        }
    }
    
}
