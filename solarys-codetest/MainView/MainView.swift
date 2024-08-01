//
//  ContentView.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            searchbar()
            
            List {
                Section {
                    ForEach(viewModel.wordHistory, id: \.word) { wordDetail in
                        NavigationLink(destination: DetailView(wordDetail: wordDetail)) {
                            Text(wordDetail.word)
                        }
                    }
                } header: {
                    Text("Searched Words")
                }
            }
        }
        .alert("Searched word cannot be found!", isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func searchbar() -> some View {
        HStack(spacing: 10) {
            Image(systemName: "text.magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Search...", text: $viewModel.searchText, onCommit: {
                viewModel.searchWord()
            })
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.searchText = ""
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
}

#Preview {
    MainView()
}
