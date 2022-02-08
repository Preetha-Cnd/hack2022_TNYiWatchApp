//
//  PlayAudioViewController.swift
//  TNYWatchApp WatchKit Extension

import WatchKit
import AVFoundation

class PlayAudioViewController: WKInterfaceController {
    
    @IBOutlet var previousTrackButton: WKInterfaceButton!
    @IBOutlet var nextTrackButton: WKInterfaceButton!
    @IBOutlet var playTrackButton: WKInterfaceButton!
    @IBOutlet var audioName: WKInterfaceLabel!
    @IBOutlet weak var progressBar: WKInterfaceImage!
    
    var audioPlayer : AVPlayer!
    let audioSession = AVAudioSession.sharedInstance()
    var isPlaying: Bool = true
    var article: String?
    var articleSelectedRowIndex = 0
    var articleItems = Article.allItems()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface object
        articleSelectedRowIndex = context as? Int ?? 0
        self.progressBar.setRelativeWidth(0.0, withAdjustment: 0)
    }
    
    override func willActivate() {
        super.willActivate()
        setupAudio(with: articleItems[articleSelectedRowIndex].url)
        
        setTitle("Now Playing")
    }
    
    override func willDisappear() {
        super.willDisappear()
        audioPlayer?.pause()
        setPausedTime()
    }
    
    func setupAudio(with urlString: String) {
        
        guard let url = URL(string: urlString) else {
            print("error to get the audio file")
            return
        }
        do {
            try audioSession.setCategory(.playback,
                                         mode: .default,
                                         policy: .longFormAudio,
                                         options: [])
            try audioSession.setActive(true)

            audioPlayer = AVPlayer(url: url as URL)
            playTrackButton.setBackgroundImageNamed("pause")
            audioName.setText("\(articleItems[articleSelectedRowIndex].name)")
            audioPlayer.play()
            
            if let time = articleItems[articleSelectedRowIndex].pausedDuration {
                audioPlayer.seek(to: CMTime(seconds: Double(time), preferredTimescale: 1))
            }
                        
            audioPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 30), queue: .main) { time in

                if let duration = self.audioPlayer.currentItem?.duration {
                    
                    let fraction = CMTimeGetSeconds(time) / CMTimeGetSeconds(duration)
                    self.progressBar.setRelativeWidth(CGFloat(fraction), withAdjustment: 0)
                }
            }
            
        } catch {
            print("audio file error")
        }
    }
    
    func setPausedTime() {
        let time = CMTimeGetSeconds((self.audioPlayer.currentItem?.currentTime())!)
        articleItems[articleSelectedRowIndex].pausedDuration = Float(time)
    }
    
    @IBAction func nextTrackAction() {
        audioPlayer.pause()
        
        setPausedTime()
        
        if articleSelectedRowIndex < articleItems.count - 1 {
            playTrackButton.setBackgroundImageNamed("play")
            articleSelectedRowIndex = articleSelectedRowIndex + 1
            setupAudio(with: articleItems[articleSelectedRowIndex].url)
        }
    }
    
    @IBAction func previousTrackAction() {
        audioPlayer.pause()
        
        setPausedTime()
        
        if articleSelectedRowIndex != 0 {
            playTrackButton.setBackgroundImageNamed("play")
            articleSelectedRowIndex = articleSelectedRowIndex - 1
            setupAudio(with: articleItems[articleSelectedRowIndex].url)
        }
    }
    
    @IBAction func playTrackAction() {
        
        if isPlaying {
            audioPlayer.pause()
            playTrackButton.setBackgroundImageNamed("play")
        } else {
            audioPlayer.play()
            playTrackButton.setBackgroundImageNamed("pause")
        }
        isPlaying = !isPlaying
    }
}
