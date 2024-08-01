//
//  AudioManager.swift
//  solarys-codetest
//
//  Created by Egon Manya on 01.08.24.
//

import AVFoundation
import SwiftUI

class AudioManager: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var phoneticId: UUID?
    private var audioPlayer: AVPlayer?
    
    func playPauseSound(url: String, id: UUID) {
        let completeUrl = url.hasPrefix("http") ? url : "https:\(url)"
        guard let url = URL(string: completeUrl) else {
            print("Invalid URL: \(completeUrl)")
            return
        }
        phoneticId = id
        
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
