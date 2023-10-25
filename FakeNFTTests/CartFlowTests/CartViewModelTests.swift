//
//  CartViewModelTests.swift
//  FakeNFTTests
//
//  Created by Aleksey Yakushev on 23.10.2023.
//

@testable import FakeNFT
import XCTest

//TODO: test vc methods
//TODO: test vm methods

//MARK: - Mock order
struct MockOrder {
    static let testItem1 = ItemNFT(createdAt: "",
                            name: "A",
                            images: [],
                            rating: 1,
                            description: "",
                            price: 100,
                            author: "",
                            id: "1")
    static let testItem2 = ItemNFT(createdAt: "",
                            name: "B",
                            images: [],
                            rating: 3,
                            description: "",
                            price: 50,
                            author: "",
                            id: "2")
    static let testItem3 = ItemNFT(createdAt: "",
                            name: "C",
                            images: [],
                            rating: 5,
                            description: "",
                            price: 80,
                            author: "",
                            id: "3")
    static let testItem4 = ItemNFT(createdAt: "",
                            name: "D",
                            images: [],
                            rating: 4,
                            description: "",
                            price: 60,
                            author: "",
                            id: "4")
    static let testItem5 = ItemNFT(createdAt: "",
                            name: "E",
                            images: [],
                            rating: 2,
                            description: "",
                            price: 110,
                            author: "",
                            id: "5")

    static let testItems: [ItemNFT] = { [testItem1,
                                         testItem2,
                                         testItem3,
                                         testItem4,
                                         testItem5] }()
}

final class CartViewModelTests: XCTestCase {
    var spyOrderService: OrderServiceProtocol & SpyOrderServiceProtocol = SpyOrderService()
    lazy var cartViewModel = CartViewModel(orderService: spyOrderService)
    
    override func setUpWithError() throws {
        spyOrderService.cartVM = cartViewModel
    }
    
    override func tearDownWithError() throws {
        spyOrderService.reset()
        cartViewModel.setSortingStyle(to: .title)
    }
    
    //MARK: - Orders
    func testSetOrder() {
        cartViewModel.setOrder(MockOrder.testItems)
        XCTAssertEqual(MockOrder.testItems, cartViewModel.currentOrderSorted)
    }
    
    func testGetOrder() {
        
    }
    
    func testOrderUpdated() {
        
    }
    
    func testRemoveItem() {
        
    }
    
    func testNetworkError() {
        
    }
    
    //MARK: - SORTING
    
    func testSortNFT() {
        let items = MockOrder.testItems.shuffled()
        
        let titleSortedItems = cartViewModel.sortNFT(items,
                                                     by: .title)
        let priceSortedItems = cartViewModel.sortNFT(items,
                                                     by: .price)
        let ratingSortedItems = cartViewModel.sortNFT(items,
                                                      by: .rating)
        
        XCTAssertEqual(titleSortedItems, [MockOrder.testItem1,
                                          MockOrder.testItem2,
                                          MockOrder.testItem3,
                                          MockOrder.testItem4,
                                          MockOrder.testItem5])
        XCTAssertEqual(priceSortedItems, [MockOrder.testItem5,
                                          MockOrder.testItem1,
                                          MockOrder.testItem3,
                                          MockOrder.testItem4,
                                          MockOrder.testItem2])
        XCTAssertEqual(ratingSortedItems, [MockOrder.testItem3,
                                           MockOrder.testItem4,
                                           MockOrder.testItem2,
                                           MockOrder.testItem5,
                                           MockOrder.testItem1])
    }
    
    func testSetSortingStyle() {
        let styles: [FakeNFT.CartSortOrder] = [.price, .rating]
        let style = styles.randomElement() ?? .rating
        cartViewModel.setSortingStyle(to: style)
        
        XCTAssertEqual(cartViewModel.sortingStyle, style)
    }
}

protocol SpyOrderServiceProtocol {
    var removedID: String { get }
    var getOrderCalled: Bool { get }
    var retryCalled: Bool { get }
    func reset()
}

final class SpyOrderService: OrderServiceProtocol {
    var cartVM: FakeNFT.CartViewModel?
    var currentOrderItems: [FakeNFT.ItemNFT] = []
    
    private(set) var removedID: String = "0"
    private(set) var getOrderCalled: Bool = false
    private(set) var retryCalled: Bool = false
    
    init(viewModel: FakeNFT.CartViewModel? = nil) {
        self.cartVM = viewModel
    }
    
    func getOrder() {
        getOrderCalled = true
    }
    
    func removeItemFromOrder(id: String) {
        removedID = id
    }
    
    func retry() {
        retryCalled = true
    }
}

extension SpyOrderService: SpyOrderServiceProtocol {
    func reset() {
        removedID = "0"
        getOrderCalled = false
        retryCalled = false
    }
}
