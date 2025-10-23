//
//  VideoPreview.swift
//  SelfUI
//
//  Created by Long Pham on 23/1/25.
//

import SwiftUI
import AVKit

public struct VideoPreview: View {
    let url: URL?
    @State private var player: AVPlayer?
    @State private var isPlayable: Bool = false
    
    public init(url: URL? = nil) {
        self.url = url
    }
    
    public var body: some View {
        VideoPlayer(player: player)
//            .frame(height: 300) // Set the frame height for the video player
            .onAppear {
                checkIfPlayable(url: self.url)
                
            }
            .onDisappear() {
                self.player?.pause()
            }
    }
    
    private func checkIfPlayable(url: URL?, completion: ((Bool) -> Void)? = nil) {
        guard let url = url else {
            completion?(false)
            return
        }
        Task {
            do {
                let asset = AVURLAsset(url: url)
                let isPlayable = try await asset.load(.isPlayable)
                self.player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
                self.isPlayable = isPlayable
                self.player?.play() // Automatically play the video when the view appears
                await MainActor.run {
                    completion?(isPlayable)
                }
                
            } catch let error {
                print("Check If Playable: \(error)")
                await MainActor.run {
                    completion?(false)
                }
            }
        }
    }
}

#Preview {
    VideoPreview(url: mainBundle!.url(forResource: "audio", withExtension: "mp3"))
}
