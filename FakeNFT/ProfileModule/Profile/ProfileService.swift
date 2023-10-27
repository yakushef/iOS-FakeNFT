//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Антон Кашников on 21/10/2023.
//

protocol ProfileServiceProtocol {
    func makeGetProfileRequest(id: String, _ handler: @escaping (Codable) -> Void)
    func makeGetNFTListRequest(id: String, _ handler: @escaping (Codable) -> Void)
    func makeGetUserRequest(id: String, _ handler: @escaping (Codable) -> Void)
    func makePutRequest(id: String, profile: Encodable, _ handler: @escaping (Codable) -> Void)
}

final class ProfileService: ProfileServiceProtocol {
    typealias Model = Codable
    
    private let networkClient = DefaultNetworkClient()
    
    func makeGetProfileRequest(id: String, _ handler: @escaping (Codable) -> Void) {
        let networkRequest = ExampleRequest(id: id)
        
        networkClient.send(request: networkRequest, type: Profile.self) { result in
            switch result {
            case .success(let success):
                handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func makeGetNFTListRequest(id: String, _ handler: @escaping (Codable) -> Void) {
        let networkRequest = SecondExampleRequest(id: id)
        
        networkClient.send(request: networkRequest, type: ItemNFT.self) { result in
            switch result {
            case .success(let success):
                handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func makeGetUserRequest(id: String, _ handler: @escaping (Codable) -> Void) {
        let networkRequest = ThirdExampleRequest(id: id)
        
        networkClient.send(request: networkRequest, type: User.self) { result in
            switch result {
            case .success(let success):
                handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func makePutRequest(id: String, profile: Encodable, _ handler: @escaping (Codable) -> Void) {
        var networkRequest = ExampleRequest(id: id, httpMethod: .put)
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
