import XCTest

class HomeViewModelTests: XCTestCase {
    func testFetchUsersList() {
        let usersJSON = """
                [
                  {
                    "login": "octocat",
                    "id": 1,
                    "node_id": "MDQ6VXNlcjE=",
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "",
                    "url": "https://api.github.com/users/octocat",
                    "html_url": "https://github.com/octocat",
                    "followers_url": "https://api.github.com/users/octocat/followers",
                    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
                    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
                    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
                    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
                    "organizations_url": "https://api.github.com/users/octocat/orgs",
                    "repos_url": "https://api.github.com/users/octocat/repos",
                    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
                    "received_events_url": "https://api.github.com/users/octocat/received_events",
                    "type": "User",
                    "site_admin": false,
                    "name": "monalisa octocat",
                    "company": "GitHub",
                    "blog": "https://www.github.com",
                    "location": "San Francisco",
                    "email": null,
                    "hireable": null,
                    "bio": "There once was...",
                    "twitter_username": null,
                    "public_repos": 2,
                    "public_gists": 1,
                    "followers": 20,
                    "following": 0,
                    "created_at": "2008-01-14T04:33:35Z",
                    "updated_at": "2023-05-05T05:51:40Z"
                  }
                ]
                """.data(using: .utf8)!

        let response = HTTPURLResponse(url: URL(string: "https://api.github.com/users/1")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

        let viewModel = HomeViewModel(urlSession: MockURLSession(data: usersJSON, response: response))
        viewModel.fetchGitHubUsers()

        XCTAssertNotNil(viewModel.users)
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users[0].publicRepos, 2)
        XCTAssertEqual(viewModel.users[0].followers, 20)
        XCTAssertEqual(viewModel.users[0].following, 0)
    }
}
