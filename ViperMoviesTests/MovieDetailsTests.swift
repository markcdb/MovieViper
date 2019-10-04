//
//  MovieDetailsTests.swift
//  MovieTests
//
//  Created by Mark Christian Buot on 11/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import XCTest
@testable import Movie

class MovieDetailsTests: XCTestCase {

    var viewModel: MovieDetailsViewModel?
    var api: MockMovieRepository?
    var expectation: XCTestExpectation?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        api         = MockMovieRepository()
        viewModel   = GlobalVMFactory.createMovieDetailsVM(repository: api,
                                                           delegate: self)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequest() {
        self.expectation = XCTestExpectation(description: "")
        
        self.viewModel?.id = Strings.mockId
        self.viewModel?.request()
        
        self.wait(for: [self.expectation!],
                  timeout: 10.0)
    }
    
    func testSimilarRequest() {
        
        self.viewModel?.id = Strings.mockId
        self.viewModel?.getSimilar(completion: {[weak self] in
            guard let self = self else { return }

            XCTAssert((self.viewModel?.getMovieCount() ?? 0) > 0, "Movie count should be > 1")
        })
    }
    
    func testSimilarRequestPaging() {
        
        self.viewModel?.id = Strings.mockId
        self.viewModel?.getSimilar(completion: {[weak self] in
            guard let self = self else { return }
            
            if (self.viewModel?.getMovieCount() ?? 0) < 20 {
                XCTFail("Movie count should be 20")
                return
            }
            
            self.viewModel?.getSimilar(completion: {
                XCTAssert((self.viewModel?.getMovieCount() ?? 0) > 20, "Movie count should be > 1")
            })
        })
    }
}

extension MovieDetailsTests: BaseVMDelegate {
    func didUpdateModelWithState(_ viewState: ViewState) {
        
        if viewState == .success(nil) {
            expectation?.fulfill()
        }
    }
}
