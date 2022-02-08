//
//  PlayPodcastIntentHandler.swift
//  PodcastsIntent
//
//  Created by S, Preetha on 08/02/22.
//

import Intents
import AVFoundation
import MediaPlayer

class PlayPodcastIntentHandler: NSObject, PlayPodcastIntentHandling {
    
    func handle(intent: PlayPodcastIntent, completion: @escaping (PlayPodcastIntentResponse) -> Void) {
        let url = URL(string: "http://api.audm.com/v5/new-yorker-audio-url-mp3?publisher-slug=newyorker&article-id=601c61a5b18004aa38d58f98")
        
        if let audioURL = url {
            
            // Donate as User Activity
            let userActivity = NSUserActivity(activityType: "tny.playback-activity-type")
            userActivity.isEligibleForSearch = true
            userActivity.title = "Play Podcast"
            userActivity.userInfo = ["previewUrl": audioURL]
            userActivity.isEligibleForPrediction = true
            userActivity.becomeCurrent()
            
            MusicPlayer.shared.set(trackName: "Reopening of Schools", url: audioURL)
            MusicPlayer.shared.play()
            let response = PlayPodcastIntentResponse(code: .continueInApp, userActivity: userActivity)
            completion(response)
        }
    }
}
