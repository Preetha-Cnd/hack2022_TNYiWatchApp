//
//  ViewController.swift
//  TNYWatchApp
//
//  Created by S, Preetha on 30/01/22.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVPlayer!
    let audioSession = AVAudioSession.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = URL(string: "http://api.audm.com/v5/new-yorker-audio-url-mp3?publisher-slug=newyorker&article-id=601c61a5b18004aa38d58f98") else {
            print("error to get the mp3 file")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = AVPlayer(url: url as URL)
            audioPlayer.play()
        } catch {
            print("audio file error")
        }
    }
}

