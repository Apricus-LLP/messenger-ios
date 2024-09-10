//
//  File.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/16/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation
import AVFoundation

class AprSdkAudio {
    var player: AVAudioPlayer?
    
    func playSound(file: String) {
        let url = Bundle.main.url(forResource: file, withExtension: "mp3")
        do {
            player = try AVAudioPlayer.init(contentsOf: url!)
            player?.play()
        } catch {
            print("ApricusLLP SDK API Error: Sound not found")
        }
    }
}
