//
//  AudioPlayerService.swift
//  TipMyService
//
//  Created by Trey Browder on 5/10/24.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class AudioPlayerClass: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        if let path = Bundle.main.path(forResource: "TipCalcReset", ofType: "m4a"){
        let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            }catch(let error) {
                print("ERROR - AUIO PLAYER ERROR: \(error)")
            }
        }
    }
}
