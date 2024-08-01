//
//  DetailView.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    
    init(wordDetail: WordDetail) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(wordDetail: wordDetail))
    }
    
    var body: some View {
        VStack {
            Form {
                VStack {
                    Text(viewModel.wordDetail.word)
                        .font(.largeTitle)
                        .padding(.bottom, 0)
                    if let phonetic = viewModel.wordDetail.phonetic {
                        Text(phonetic)
                            .padding(.vertical, 4)
                    }
                }
                
                if let origin = viewModel.wordDetail.origin {
                    Section(header: Text("Origin").font(.headline)) {
                        Text(origin)
                            .padding(.vertical)
                    }
                }
                
                if !viewModel.wordDetail.phonetics.isEmpty {
                    Section(header: Text("Phonetics").font(.headline)) {
                        ForEach(viewModel.wordDetail.phonetics, id: \.id) { phonetic in
                            HStack {
                                if let text = phonetic.text {
                                    Text(text)
                                }
                                
                                Spacer()
                                
                                if let audioURL = phonetic.audio {
                                    audioPlayer(url: audioURL, id: phonetic.id)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                if !viewModel.wordDetail.meanings.isEmpty {
                    Section(header: Text("Meanings").font(.headline)) {
                        ForEach(viewModel.wordDetail.meanings, id: \.self) { meaning in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(meaning.partOfSpeech.capitalized)
                                    .font(.subheadline)
                                    .bold()
                                    .padding(.vertical, 4)
                                
                                ForEach(meaning.definitions, id: \.self) { definition in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(definition.definition)
                                            .padding(.vertical, 4)
                                        
                                        if let example = definition.example {
                                            Text("Example: \(example)")
                                                .italic()
                                                .foregroundColor(.gray)
                                                .padding(.vertical, 2)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.wordDetail.word)
        }
    }
    
    func audioPlayer(url: String, id: UUID) -> some View {
        return Button(action: {
            viewModel.playPauseSound(for: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3", id: id)
        }) {
            Image(systemName: (viewModel.isPlaying && viewModel.currentPlayingPhoneticId == id) ? "pause.circle" : "play.circle")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    DetailView(wordDetail: WordDetail())
}
