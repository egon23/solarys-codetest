//
//  DetailViewModelTests.swift
//  solarys-codetest
//
//  Created by Egon Manya on 02.08.24.
//


import XCTest
@testable import solarys_codetest

class DetailViewModelTests: XCTestCase {
    
    var detailViewModel: DetailViewModel!
    var mockWordDetail: WordDetail!
    
    override func setUpWithError() throws {
        mockWordDetail = WordDetail()
        detailViewModel = DetailViewModel(wordDetail: mockWordDetail)
    }
    
    override func tearDownWithError() throws {
        detailViewModel = nil
        mockWordDetail = nil
    }
    
    func testInitialValues() {
        XCTAssertEqual(detailViewModel.wordDetail, mockWordDetail)
        XCTAssertFalse(detailViewModel.isPlaying)
    }
    
    func testPlayPauseSound() {
        let phonetic = Phonetic()
        phonetic.audio = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
        
        detailViewModel.playPauseSound(for: phonetic)
        XCTAssertTrue(detailViewModel.isPlaying)
        XCTAssertEqual(detailViewModel.currentPlayingPhoneticId, phonetic.id)
        
        detailViewModel.playPauseSound(for: phonetic)
        XCTAssertFalse(detailViewModel.isPlaying)
    }
}

