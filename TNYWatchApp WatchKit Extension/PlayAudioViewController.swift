//
//  PlayAudioViewController.swift
//  TNYWatchApp WatchKit Extension
//
//  Created by Saini, Priyanka on 02/02/22.
//

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
    }
    
    override func willActivate() {
        super.willActivate()
        setupAudio(with: articleItems[articleSelectedRowIndex].url)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func setupAudio(with urlString: String) {
        
        guard let url = URL(string: urlString) else {
            print("error to get the audio file")
            return
        }
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            try audioSession.setActive(true)

            audioPlayer = AVPlayer(url: url as URL)
            playTrackButton.setBackgroundImageNamed("pause")
            audioName.setText("\(articleItems[articleSelectedRowIndex].name)")
            audioPlayer.play()
        } catch {
            print("audio file error")
        }
    }
    
    @IBAction func nextTrackAction() {
        audioPlayer.pause()
        if articleSelectedRowIndex < articleItems.count - 1 {
            playTrackButton.setBackgroundImageNamed("play")
            articleSelectedRowIndex = articleSelectedRowIndex + 1
            setupAudio(with: articleItems[articleSelectedRowIndex].url)
        }
    }
    
    @IBAction func previousTrackAction() {
        audioPlayer.pause()
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
