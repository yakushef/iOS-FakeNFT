import Foundation

struct ExampleRequest: NetworkRequest {
    var endpoint: URL?
    var id: String
    var httpMethod: HttpMethod
    var dto: Encodable?
    
    init(id: String, httpMethod: HttpMethod = .get) {
        self.id = id
        self.httpMethod = httpMethod
        endpoint = URL(string: "\(Config.baseUrl)profile/\(self.id)")
    }
}

struct SecondExampleRequest: NetworkRequest {
    var endpoint: URL?
    var id: String
    var httpMethod: HttpMethod = .get
    
    init(id: String) {
        self.id = id
        endpoint = URL(string: "\(Config.baseUrl)nft/\(self.id)")
    }
}

struct ThirdExampleRequest: NetworkRequest {
    var endpoint: URL?
    var id: String
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
    
    init(id: String) {
        self.id = id
        endpoint = URL(string: "\(Config.baseUrl)users/\(self.id)")
    }
}
