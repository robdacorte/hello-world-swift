
import AVFoundation
import UIKit


class AudioAnalizer: NSObject, AVAudioRecorderDelegate {
    var audioSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    var isRecording: Bool = false
    var currentPulseDb0: Float = 0
    var currentPulsePk0: Float = 0
    
    private var recorder : AVAudioRecorder? = nil
    private var timer: Timer?
    
    override init() {
        self.audioSession = AVAudioSession.sharedInstance()
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
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                    
                    self?.player.updateMeters()
                    let db0 = self?.player.averagePower(forChannel: 0)
//                    let db1 = self?.player.averagePower(forChannel: 1)
                    let peak0 = self?.player.peakPower(forChannel: 0)
//                    let peak1 = self?.player.peakPower(forChannel: 1)
                    
                    print("is another audio playing: \(String(describing: self?.audioSession.description))")
                    print("pk0--> ", String(format: "%6.2f", peak0 ?? "-"))
                    print("db0--> ", String(format: "%6.2f", db0 ?? "-"))
                    
                    
                    //                    print(" a lo loco numero de output channels->",self.recordingSession.outputNumberOfChannels)
                }
                
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            
            print("no habemus file")
        }
        
        
    }
    
    private func start() {
        recorder?.record()
        recorder?.updateMeters()
    }
    
    func stopRecording() {
        recorder?.stop()
    }
    
//    from https://developer.apple.com/forums/thread/721535
    func fixMainOutput() {
        do {
//            need to test this pair, had to quit wife got mental
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.sharedInstance().category)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func trackPulse() -> Void {
        
            do {
                
//                try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
                
                fixMainOutput()
                
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .measurement, options: [.mixWithOthers])
                try audioSession.setActive(true)
                
                
                let settings = [
                            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey: 48000,
                            AVNumberOfChannelsKey: 1,
                            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                        ]
                let url = getDocumentsDirectory()
                print("Psst")
                print(url)
                try recorder = AVAudioRecorder(url: url, settings: settings)
                recorder!.delegate = self
                recorder!.isMeteringEnabled = true

                isRecording = true;
                self.start()
                if !recorder!.prepareToRecord() {
                    print("Error: AVAudioRecorder prepareToRecord failed")
                }

                recorder?.isMeteringEnabled = true
                
//                print("habemus file")
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                    
                    self?.recorder?.updateMeters()
                    self?.fixMainOutput()
                    let db0 = self?.recorder?.averagePower(forChannel: 0)
//                    let db1 = self?.recorder?.averagePower(forChannel: 1)
                    self?.currentPulseDb0 = db0 ?? 0
                    
                    let peak0 = self?.recorder?.peakPower(forChannel: 0)
                    self?.currentPulsePk0 = peak0 ?? 0
//                    let peak1 = self?.recorder?.peakPower(forChannel: 1)
                    
//                    print("is another audio playing: \(String(describing: self?.audioSession.description))")
//                    print("pk0--> ", String(format: "%6.2f", peak0 ?? "-"))
                    print("db0--> ", String(format: "%6.2f", db0 ?? "-"))
                    
                    
                    //                    print(" a lo loco numero de output channels->",self.recordingSession.outputNumberOfChannels)
                }
                
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        let fileManager         = FileManager.default
        let urls                = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory   = urls.first!
        return documentDirectory.appendingPathComponent("recording.m4a")
    }
    
    func startRecording() {
        self.audioSession = AVAudioSession.sharedInstance()
        do
        {
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: [.mixWithOthers]
            
            )
            try audioSession.setActive(true)
            audioSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("we are allowed!!")
                        //                        self.loadRecordingUI()
                        //                            self.keepRolling()
                        
                        //                            Aqui comenzar la lógica que obtiene los decibeles del mic y los evalua y los publica
                        //                            en alguna variable tipo pulse
                        
                        self.trackPulse()
                    } else {
                        print("Error: we are not allowed :(")
                        // failed to record!
                    }
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
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
    
    func monitorAudioLevel (_ lengthInSeconds: TimeInterval) -> Void {
        let equivalentToSilence: Float = -24
        timer?.invalidate()
        timer = Timer.scheduledTimer (withTimeInterval: lengthInSeconds, repeats: false) { [self] (_) in
            audioRecorder.updateMeters () ;
            if audioRecorder.isRecording {
                monitorAudioLevel(3)
                audioRecorder.updateMeters () ;
                let decibels = audioRecorder.averagePower (forChannel: 0);
                let thisIsSilence: Bool = (decibels < equivalentToSilence)
                print ("is silence? -> \(thisIsSilence), decibels -> \(decibels)")
                if thisIsSilence {
                    audioRecorder.stop ()
//                    finishRecording (success: true)
                    
                }
            }
        }
    }
    
}
