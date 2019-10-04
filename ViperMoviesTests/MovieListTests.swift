//
//  MovieTests.swift
//  MovieTests
//
//  Created by Mark Christian Buot on 10/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import XCTest
@testable import Movie

fileprivate enum TestCase: Equatable {
    
    case listRequest
    case pageRequest(Bool)
    case imageUrl
    case pullToRefresh
    case fail
    
    static func == (lhs: TestCase, rhs: TestCase) -> Bool {
        
        switch (lhs, rhs) {
        case (.listRequest, .listRequest):
            return true
        case (.pageRequest(_), .pageRequest(_)):
            return true
        case (.imageUrl, .imageUrl):
            return true
        case (.pullToRefresh, .pullToRefresh):
            return true
        case (.fail, .fail):
            return true
        default:
            return false
        }
    }

    var rawValue: String {
        switch self {
        case .listRequest:
            return "listRequest"
        case .imageUrl:
            return "imageUrl"
        case .pullToRefresh:
            return "pullToRefresh"
        case .fail:
            return "fail"
        default:
            return "pageRequest"
        }
    }
}

class MovieListTests: XCTestCase {

    var dispatchGroup  = DispatchGroup()

    fileprivate var testCase: TestCase?
    var expectation: XCTestExpectation?
    var viewModel: MovieListViewModel?
    var api: MockMovieRepository?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        api       = MockMovieRepository()
        viewModel = GlobalVMFactory.createMovieListVM(repository: api,
                                                      delegate: self)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListRequest() {
        testCase    = .listRequest
        expectation = XCTestExpectation(description: testCase?.rawValue ?? blank_)
        viewModel?.request()
        
        wait(for: [expectation!],
             timeout: 10.0)
    }
    
    func testListRequestPaging() {
        testCase    = .pageRequest(false)
        expectation = XCTestExpectation(description: testCase?.rawValue ?? blank_)
        viewModel?.request()
        
        dispatchGroup.enter()
        dispatchGroup.notify(queue: .main) {
            self.viewModel?.request()
            self.testCase    = .pageRequest(true)
        }
        
        wait(for: [expectation!],
             timeout: 10.0)
    }
    
    func testImageUrlRequest() {
        testCase    = .imageUrl
        viewModel?.request()
        
        dispatchGroup.enter()
        dispatchGroup.notify(queue: .main) {
            if let path = self.viewModel?.getMoviePosterPathAt(0),
                let urlString = path.getImageUrlStringWith(200),
                let url = URL(string: urlString) {
                XCTAssert(UIApplication.shared.canOpenURL(url) == true,
                          "URL is valid")
            }
        }
    }
    
    func testPullToRefresh() {
        testCase    = .pullToRefresh
        viewModel?.request()
        expectation = XCTestExpectation(description: testCase?.rawValue ?? blank_)

        dispatchGroup.enter()
        dispatchGroup.notify(queue: .main) {
            //Do Another request for the 2nd page
            self.viewModel?.request()
            
            self.dispatchGroup.enter()
            self.dispatchGroup.notify(queue: .main, execute: {

                self.viewModel?.resetPage()
                self.viewModel?.request()
                
                self.dispatchGroup.enter()
                self.dispatchGroup.notify(queue: .main, execute: {
                    XCTAssert(self.viewModel?.getMovieCount() == 20, "Pull to refresh resets the page")
                    self.expectation?.fulfill()
                })
            })
        }
        
        wait(for: [expectation!],
             timeout: 10.0)
    }
    
    func testFailable() {
        testCase      = .fail
        api?.failable = true
        expectation   = XCTestExpectation(description: testCase?.rawValue ?? blank_)
        viewModel?.request()
        
        wait(for: [expectation!],
             timeout: 10.0)
    }
}

extension MovieListTests: BaseVMDelegate {
    func didUpdateModelWithState(_ viewState: ViewState) {
        if viewState == .success(nil) {
            switch testCase {
            case .listRequest?:
                expectation?.fulfill()
            case .pageRequest(let isComplete)?:
                if isComplete == true,
                    (self.viewModel?.movies.count ?? 0) > 20 {
                    expectation?.fulfill()
                } else {
                    dispatchGroup.leave()
                }
            case .imageUrl?:
                dispatchGroup.leave()
            case .pullToRefresh?:
                dispatchGroup.leave()
            default:
                break
            }
        } else if viewState == .error(nil),
            testCase == .fail {
            expectation?.fulfill()
        }
    }
}
