//
//  MeditationViewModel.swift
//  Hello World
//
//  Created by Carlos Limonggi on 20/12/23.
//

import SwiftUI
import Combine
import AVFoundation

class MeditationViewModel: ObservableObject {
    //MARK: - Properties
    @Published var minutes: Int = 1
    @Published var seconds: Int = 20
    @Published var totalSeconds: Int = 0
    @Published var isActive: Bool = false
    @Published var player: AVPlayer = AVPlayer(url: Bundle.main.url(forResource: "ocean_waves_loop", withExtension: "mov")!)
    private var isPlayerPlayingReverse: Bool = false
    private var staticTotalSeconds: Int = 0
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Functions
    func startTimer(){
        withAnimation {
            isActive = true
        }
        totalSeconds = (minutes * 60) + seconds
        staticTotalSeconds = totalSeconds
        Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink(receiveValue: { [weak self] _ in
            self?.updateTimer()
        }).store(in: &cancellable)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(videoDidFinish),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        player.play()
    }
    
    func updateTimer(){
        if !isActive {
            stopTimer()
            return
        }
        totalSeconds -= 1
        minutes = (totalSeconds / 60) % 60
        seconds = totalSeconds % 60
        isActive = totalSeconds != 0
    }
    
    func stopTimer() {
        isActive = false
        player.pause()
        player.seek(to: .zero)
        minutes = 1
        seconds = 20
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        cancellable.removeAll()
    }
    
    func getUpdatedTime() -> String{
        isActive ? "\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")" : "00:00"
    }
    
    func getPercentage() -> CGFloat {
        isActive ? (CGFloat(totalSeconds * 100) / CGFloat(staticTotalSeconds)) / 100 : 0
    }
    
    @objc private func videoDidFinish(notification: Notification) {
        if notification.object is AVPlayerItem {
            withAnimation(.smooth) {
                player.playImmediately(atRate: isPlayerPlayingReverse ? 1.0 : -1.5)
                isPlayerPlayingReverse.toggle()
            }
        }
    }
}
