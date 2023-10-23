//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Антон Кашников on 21/10/2023.
//

protocol ProfileServiceProtocol {
}

final class ProfileService: ProfileServiceProtocol {
    private let networkClient = DefaultNetworkClient()
    
    func makeRequest(_ handler: @escaping (Profile) -> Void) {
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
}
