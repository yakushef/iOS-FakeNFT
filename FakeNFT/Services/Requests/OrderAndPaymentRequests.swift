//
//  OrderAndPaymentRequests.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 22.10.2023.
//

import Foundation

struct cartRequest: NetworkRequest {
    var endpoint: URL?
}

struct cartChangeRequest: NetworkRequest {
    var endpoint: URL?
    var httpMethod: HttpMethod = .put
    var dto: [String]
}
