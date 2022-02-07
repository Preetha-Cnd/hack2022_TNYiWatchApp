//
//  InterfaceController.swift
//  TNYWatchApp WatchKit Extension
//
//  Created by S, Preetha on 30/01/22.
//

import WatchKit
import Foundation
import AVFoundation

class InterfaceController: WKInterfaceController {
    
    var audioPlayer : AVPlayer!
    @IBOutlet weak var playButton: WKInterfaceButton!
    @IBOutlet weak var previousAudioPlayButton: WKInterfaceButton!
    @IBOutlet weak var playPauseButton: WKInterfaceButton!
    @IBOutlet weak var nextAudioPlayButton: WKInterfaceButton!
    let audioSession = AVAudioSession.sharedInstance()
    var isPlaying: Bool = false
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        super.willActivate()
        
        guard let url = URL(string: "http://api.audm.com/v5/new-yorker-audio-url-mp3?publisher-slug=newyorker&article-id=601c61a5b18004aa38d58f98") else {
            print("error to get the audio file")
            return
        }
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            try audioSession.setActive(true)

            audioPlayer = AVPlayer(url: url as URL)
        } catch {
            print("audio file error")
        }
    }
    
    @IBAction func playAudioAction() {
        if isPlaying {
            audioPlayer.pause()
            playButton.setTitle("Play Audio")
        } else {
            audioPlayer.play()
            playButton.setTitle("Pause Audio")
        }
        isPlaying = !isPlaying
    }
    
    @IBAction func playPauseAusioAction() {
        
        if isPlaying {
            audioPlayer.pause()
            playPauseButton.setBackgroundImage(UIImage(named: "pause"))
        } else {
            audioPlayer.play()
            playPauseButton.setBackgroundImage(UIImage(named: "play"))
        }
        isPlaying = !isPlaying
    }
    
    @IBAction func playpreviousTrackAction() {
    }
    
    @IBAction func playNextTrackAction() {
    }
    
}
