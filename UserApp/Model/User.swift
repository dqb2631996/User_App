import Foundation

struct User : Codable{
    let id: Int
    let avatarUrl: String
    let login: String
    let publicRepos: Int?
    let followers: Int?
    let following: Int?
    let bio: String?
}
