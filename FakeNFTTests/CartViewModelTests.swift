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
let testItem1 = ItemNFT(createdAt: "",
                        name: "A",
                        images: [],
                        rating: 1,
                        description: "",
                        price: 100,
                        author: "",
                        id: "1")
let testItem2 = ItemNFT(createdAt: "",
                        name: "B",
                        images: [],
                        rating: 3,
                        description: "",
                        price: 50,
                        author: "",
                        id: "2")
let testItem3 = ItemNFT(createdAt: "",
                        name: "C",
                        images: [],
                        rating: 5,
                        description: "",
                        price: 80,
                        author: "",
                        id: "3")
let testItem4 = ItemNFT(createdAt: "",
                        name: "D",
                        images: [],
                        rating: 4,
                        description: "",
                        price: 60,
                        author: "",
                        id: "4")
let testItem5 = ItemNFT(createdAt: "",
                        name: "E",
                        images: [],
                        rating: 2,
                        description: "",
                        price: 110,
                        author: "",
                        id: "5")

let testItems: [ItemNFT] = [testItem1,
                            testItem2,
                            testItem3,
                            testItem4,
                            testItem5]

final class CartViewModelTests: XCTestCase {
    var spyOrderService: OrderServiceProtocol = SpyOrderService()
    lazy var cartViewModel = CartViewModel(orderService: spyOrderService)
    
    override func setUpWithError() throws {
        spyOrderService.cartVM = cartViewModel
    }
    
    override func tearDownWithError() throws {
        
    }
    
    //ORDERS
    func testSetOrder() {
        
    }
    
    func testGetOrder() {
        
    }
    
    func testOrderUpdated() {
        
    }
    
    func testRemoveItem() {
        
    }
    
    func testNetworkError() {
        
    }
    
    //SORTING
    
    func testSortNFT() {
        let items = testItems.shuffled()
        
        let titleSortedItems = cartViewModel.sortNFT(items,
                                                     by: .title)
        let priceSortedItems = cartViewModel.sortNFT(items,
                                                     by: .price)
        let ratingSortedItems = cartViewModel.sortNFT(items,
                                                      by: .rating)
        
        XCTAssertEqual(titleSortedItems, [testItem1, testItem2, testItem3, testItem4, testItem5])
        XCTAssertEqual(priceSortedItems, [testItem5, testItem1, testItem3, testItem4, testItem2])
        XCTAssertEqual(ratingSortedItems, [testItem3, testItem4, testItem2, testItem5, testItem1])
    }
    
    func testSetRortingStyle() {
        let styles: [FakeNFT.CartSortOrder] = [.price, .rating]
        let style = styles.randomElement() ?? .rating
        cartViewModel.setSortingStyle(to: style)
        
        XCTAssertEqual(cartViewModel.sortingStyle, style)
    }
}

final class SpyOrderService: OrderServiceProtocol {
    var cartVM: FakeNFT.CartViewModel?
    
    var currentOrderItems: [FakeNFT.ItemNFT] = []
    
    init(viewModel: FakeNFT.CartViewModel? = nil) {
        self.cartVM = viewModel
    }
    
    func getOrder() {
        
    }
    
    func removeItemFromOrder(id: String) {
        
    }
    
    func retry() {
        
    }
}
