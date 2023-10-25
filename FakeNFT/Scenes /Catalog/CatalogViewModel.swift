//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Andy Kruch on 10.10.23.
//

import Foundation

final class CatalogViewModel: NSObject {
    
    private (set) var collections: [Collection] = []
    
    var reloadData: (() -> Void)?
    var loadingStarted: (() -> Void)?
    var loadingFinished: (() -> Void)?
    
    var onError: ((_ error: Error, _ retryAction: @escaping () -> Void) -> Void)?
    
    private let sorter = SortNFTsCollections()
    
    override init() {
        super.init()
    }
    
    func updateData() {
        fetchData()
    }
    
    private func fetchData() {
        loadingStarted?()
        DefaultNetworkClient().send(request: CollectionRequests.collection, type: [Collection].self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.collections = data
                DispatchQueue.main.async {
                    self?.loadingFinished?()
                    self?.reloadData?()
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error) { [weak self] in
                        self?.fetchData()
                    }
                }
            }
        }
    }
    
    func sortByName() {
        collections = collections.sorted {
            $0.name < $1.name
        }
        sorter.setSortValue(value: SortNFTsCollectionType.byName.rawValue)
        reloadData?()
    }
    
    func sortByNFTsCount() {
        collections = collections.sorted {
            $0.nfts.count > $1.nfts.count
        }
        sorter.setSortValue(value: SortNFTsCollectionType.byNFTsCount.rawValue)
        reloadData?()
    }
}

