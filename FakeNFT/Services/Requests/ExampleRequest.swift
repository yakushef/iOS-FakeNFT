import Foundation

struct ExampleRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(Config.baseUrl)profile/1")
    }
    
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
}
