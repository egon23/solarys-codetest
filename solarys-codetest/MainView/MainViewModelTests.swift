//
//  MainViewModelTests.swift
//  solarys-codetestTests
//
//  Created by Egon Manya on 02.08.24.
//

import XCTest
@testable import solarys_codetest

class MainViewModelTests: XCTestCase {
    
    var mainViewModel: MainViewModel!
    
    override func setUpWithError() throws {
        mainViewModel = MainViewModel()
    }
    
    override func tearDownWithError() throws {
        mainViewModel = nil
    }
    
    func testInitialValues() {
        XCTAssertEqual(mainViewModel.searchText, "")
        XCTAssertFalse(mainViewModel.showingAlert)
    }
    
    func testSearchWordSuccess() {
        // Assuming we have a mock service that returns success
        let mockService = MockDictionaryService()
        mockService.result = .success(WordDetail.sampleData[0])
        mainViewModel.dictionaryService = mockService
        mainViewModel.searchText = "test"
        
        mainViewModel.searchWord()
        
        XCTAssertEqual(mainViewModel.searchText, "")
        XCTAssertFalse(mainViewModel.showingAlert)
    }
    
    func testSearchWordFailure() {
        // Assuming we have a mock service that returns failure
        let mockService = MockDictionaryService()
        mockService.result = .failure(NSError(domain: "", code: 404, userInfo: nil))
        mainViewModel.dictionaryService = mockService
        mainViewModel.searchText = "unknown"
        
        mainViewModel.searchWord()
        
        XCTAssertTrue(mainViewModel.showingAlert)
    }
}
