import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let completionHandler: () -> Void

    init(completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
    }

    override func resume() {
        completionHandler()
    }
}

class MockURLSession: URLSession {
    private let data: Data
    private let response: URLResponse
    private let error: Error?

    init(data: Data, response: URLResponse, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = MockURLSessionDataTask { [weak self] in
            completionHandler(self?.data, self?.response, self?.error)
        }
        return task
    }
}
