
import AVFoundation
import UIKit


class AudioAnalizer {
    var audioSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    
     init() {
        self.audioSession = AVAudioSession.sharedInstance()
//        do
//            {
//                try audioSession.setCategory(.record, mode: .default)
//                try audioSession.setActive(true)
//                audioSession.requestRecordPermission() { allowed in
//                    DispatchQueue.main.async {
//                        if allowed {
//                            print("we are allowed!!")
//    //                        self.loadRecordingUI()
//                            self.keepRolling()
//                        } else {
//                            // failed to record!
//                        }
//                    }
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }

    }
    func keepRolling() -> Void {
        if let asset = NSDataAsset(name:"sil_wav") {
            do {
                
                try audioSession.setCategory(.ambient, mode: .default)
                try audioSession.setActive(true)
                
                if player == nil {
                    player = try AVAudioPlayer(data: asset.data)
                }
                
                // Play the above sound file.
//                let _ : Any = player.isPlaying ? player.stop() : player.play()

                player.isMeteringEnabled = true

                
                if player.isPlaying {
                    print("just about to stop")
                    player.stop()
                } else {
                    print("just about to start")
                    player.play()
                }
                

                print("habemus file")
                Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in

                    self?.player.updateMeters()
                    let db0 = self?.player.averagePower(forChannel: 0)
                    let db1 = self?.player.averagePower(forChannel: 1)
                    
                    let peak0 = self?.player.peakPower(forChannel: 0)
                    let peak1 = self?.player.peakPower(forChannel: 1)
                    
                    print("is another audio playing: \(String(describing: self?.audioSession.description))")
                    print("pk0--> ", String(format: "%6.2f", peak0 ?? "-"), "  pk1--> ", String(format: "%6.2f", peak1 ?? "-"))
                    print("db0--> ", String(format: "%6.2f", db0 ?? "-"), "  db1--> ", String(format: "%6.2f", db1 ?? "-"))


//                    print(" a lo loco numero de output channels->",self.recordingSession.outputNumberOfChannels)
                }
                
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            
            print("no habemus file")
        }
        
        
    }
//    var engine : AVAudioEngine!
//
//    public func setupAudio(){
//        /* Setup & Start Engine */
//
//        //initialize it
//        engine = AVAudioEngine()
//
//        //initialzing the mainMixerNode singleton which will connect to the default output node
//        _ = engine.mainMixerNode
////        engine.mainMixerNode
//        print(engine.mainMixerNode.outputVolume)
//        //prepare and start
////        engine.prepare()
////        do {
////            try engine.start()
////            print(engine.accessibilityHint)
////        } catch {
////            print(error)
////        }
//    }
}
