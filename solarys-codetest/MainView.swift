//
//  ContentView.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    @State private var searchText = ""
    @State private var showingAlert = false
    @ObservedResults(WordDetail.self) var wordHistory
    
    
    var body: some View {
        VStack {
            searchbar()
            
            List {
                Section {
                    ForEach(wordHistory, id: \.word) { wordDetail in
                        NavigationLink(destination: DetailView(wordDetail: wordDetail)) {
                            Text(wordDetail.word)
                        }
                    }
                } header: {
                    Text("Searched Words")
                }
            }
        }
        .alert("Searched word cannot be found!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func searchbar() -> some View {
        return HStack(spacing: 10) {
            Image(systemName: "text.magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Search...", text: $searchText, onCommit: {
                searchWord()
            })
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "x.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.gray))
        .padding()
    }
    
    private func searchWord() {
        guard !searchText.isEmpty else { return }
        DictionaryService().fetchWordDetails(for: searchText) { result in
            switch result {
            case .success(_):
                // WordDetail successfully fetched and saved to Realm
                searchText = ""
                break
            case .failure(let error):
                showingAlert = true
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    MainView()
}
