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
        disableFirstAndLastAudioTrackButton()
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
        disableFirstAndLastAudioTrackButton()
    }
    
    @IBAction func previousTrackAction() {
        audioPlayer.pause()
        setPausedTime()
        
        if articleSelectedRowIndex != 0 {
            playTrackButton.setBackgroundImageNamed("play")
            articleSelectedRowIndex = articleSelectedRowIndex - 1
            setupAudio(with: articleItems[articleSelectedRowIndex].url)
        }
        disableFirstAndLastAudioTrackButton()
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
    
    func disableFirstAndLastAudioTrackButton() {
        if articleSelectedRowIndex == 0 {
            previousTrackButton.setEnabled(false)
        } else if articleSelectedRowIndex == articleItems.count - 1 {
            nextTrackButton.setEnabled(false)
        } else {
            nextTrackButton.setEnabled(true)
            previousTrackButton.setEnabled(true)
        }
    }
}
