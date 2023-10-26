//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Антон Кашников on 21/10/2023.
//

protocol ProfileServiceProtocol {
    func makeGetRequest(_ handler: @escaping (Codable) -> Void)
    func makePutRequest(profile: Encodable, _ handler: @escaping (Codable) -> Void)
}

final class ProfileService: ProfileServiceProtocol {
    private let networkClient = DefaultNetworkClient()
    
    func makeGetRequest(_ handler: @escaping (Codable) -> Void) {
        let networkRequest = ExampleRequest()
        
        networkClient.send(request: networkRequest, type: Profile.self) { result in
            switch result {
            case .success(let success):
                handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func makePutRequest(profile: Encodable, _ handler: @escaping (Codable) -> Void) {
        var networkRequest = ExampleRequest(httpMethod: .put)
        networkRequest.dto = profile
        
        networkClient.send(request: networkRequest, type: Profile.self) { result in
            switch result {
            case .success(let success):
                handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
