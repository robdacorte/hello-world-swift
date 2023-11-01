
import AVFoundation
import UIKit


class AudioAnalizer: NSObject, AVAudioRecorderDelegate, ObservableObject {
    var audioSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    var isRecording: Bool = false
    @Published var currentPulseDb0: Float = 0
    @Published var currentPulsePk0: Float = 0
    
    private var recorder : AVAudioRecorder!
    private var timer: Timer?
    private var outterTimer: Timer?
    
    override init() {
        self.audioSession = AVAudioSession.sharedInstance()
    }
    
    private func start() {
        recorder.record()
        recorder.updateMeters()
    }
    
    func stop() {
        recorder.stop()
    }
    
    //    from https://developer.apple.com/forums/thread/721535
    func fixMainOutput() {
        do {
            //            need to test this pair
            //            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.sharedInstance().category)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func trackPulse() -> Void {
        
        self.outterTimer?.invalidate()
        self.outterTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self]_ in
            guard let self = self else {return}
            
            print("-------------------outter loop passing")
                            if self.isRecording {
                                
                                do {
//                                    fixMainOutput()
                                    
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
//                                    //https://stackoverflow.com/questions/74392536/how-to-set-1hz-for-recording-in-avaudiorecorder
                                    
                                    recorder.delegate = self
                                    recorder.isMeteringEnabled = true
                                    
                                    start()
                                    
                                    if !recorder.prepareToRecord() {
                                        print("Error: AVAudioRecorder prepareToRecord failed")
                                    }
                                    recorder.isMeteringEnabled = true
                                    
                                    timer?.invalidate()
                                    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {_ in
                                        print("inner loop passing")
                                        self.recorder.updateMeters()
//                                        self?.fixMainOutput()
                                        let db0 = self.recorder.averagePower(forChannel: 0)
                                        self.currentPulseDb0 = db0 
                                        
                                        let peak0 = self.recorder.peakPower(forChannel: 0)
                                        self.currentPulsePk0 = peak0 
                                        print("db0--> ", String(format: "%6.2f", db0 ))
                                    }
                                    
                                   // stop()
                                    
                                } catch let error as NSError {
                                    print(error.localizedDescription)
                                }
                                
                            } else {
                                timer?.invalidate()
                                outterTimer?.invalidate()
                            }
                        }
                    
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        let fileManager         = FileManager.default
        let urls                = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory   = urls.first!
        return documentDirectory.appendingPathComponent("recording.m4a")
    }
    
    func outterStop() {
        self.stop()
        self.isRecording = false;
    }
    
    func outterStart() {
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
                        self.isRecording = true;
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
    
}
