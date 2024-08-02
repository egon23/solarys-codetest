//
//  DetailViewModel.swift
//  solarys-codetest
//
//  Created by Egon Manya on 02.08.24.
//

import SwiftUI
import AVFoundation
import RealmSwift

class DetailViewModel: ObservableObject {
    @Published var wordDetail: WordDetail
    @Published var isPlaying: Bool = false
    @Published var currentPlayingPhoneticId: UUID?
    private var audioPlayer: AVPlayer?
    
    init(wordDetail: WordDetail) {
        self.wordDetail = wordDetail
    }
    
    func playPauseSound(for phonetic: Phonetic) {
        let completeUrl = phonetic.audio!.hasPrefix("http") ? phonetic.audio! : "https:\(phonetic.audio!)"
        guard let url = URL(string: completeUrl) else {
            print("Invalid URL: \(completeUrl)")
            return
        }
        currentPlayingPhoneticId = phonetic.id
        
        if isPlaying {
            // Pause the audio
            audioPlayer?.pause()
            isPlaying = false
        } else {
            // Check if the current player item URL matches the requested URL
            if let currentItem = audioPlayer?.currentItem,
               let currentAsset = currentItem.asset as? AVURLAsset,
               currentAsset.url == url {
                // Resume playback
                audioPlayer?.play()
            } else {
                // Create a new player item with the URL
                let playerItem = AVPlayerItem(url: url)
                audioPlayer = AVPlayer(playerItem: playerItem)
                audioPlayer?.play()
            }
            isPlaying = true
        }
    }
}

