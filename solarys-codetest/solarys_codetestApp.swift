//
//  solarys_codetestApp.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import SwiftUI
import AVFoundation


@main
struct solarys_codetestApp: App {
    init() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Failed to set up audio session: \(error.localizedDescription)")
            }

    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
        }
    }
}
