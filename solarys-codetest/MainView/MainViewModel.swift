//
//  MainViewModel.swift
//  solarys-codetest
//
//  Created by Egon Manya on 02.08.24.
//

import SwiftUI
import RealmSwift

class MainViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var showingAlert = false
    @ObservedResults(WordDetail.self) var wordHistory
    
    var dictionaryService: DictionaryService
    
    init(dictionaryService: DictionaryService = DictionaryService()) {
        self.dictionaryService = dictionaryService
    }
    
    func searchWord() {
        guard !searchText.isEmpty else { return }
        dictionaryService.fetchWordDetails(for: searchText) { result in
            switch result {
            case .success(_):
                self.searchText = ""
                self.showingAlert = false
            case .failure(let error):
                self.showingAlert = true
                print(error.localizedDescription)
            }
        }
    }
}
