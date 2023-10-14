//
//  CatalogRequest.swift
//  FakeNFT
//
//  Created by Andy Kruch on 14.10.23.
//

import Foundation

enum CollectionRequests: NetworkRequest {
    case example
    case collection
    
    var endpoint: URL? {
        switch self {
        case .example:
            return URL(string: "https://651ff0e9906e276284c3c24a.mockapi.io/api/v1/:endpoint")
        case .collection:
            return URL(string: "https://651ff0e9906e276284c3c24a.mockapi.io/api/v1/collections")
        }
    }
}
