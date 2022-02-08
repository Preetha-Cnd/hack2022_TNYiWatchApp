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
    
    static var count: Int = 0
    
    func handle(intent: PlayPodcastIntent, completion: @escaping (PlayPodcastIntentResponse) -> Void) {
        
        let url = URL(string: getURLForIntentTitle().1)
        
        if let audioURL = url {
            
            // Donate as User Activity
            let userActivity = NSUserActivity(activityType: "tny.playback-activity-type")
            userActivity.isEligibleForSearch = true
            userActivity.title = "Play Podcast"
            userActivity.userInfo = ["previewUrl": audioURL]
            userActivity.isEligibleForPrediction = true
            userActivity.becomeCurrent()
            
            MusicPlayer.shared.set(trackName: getURLForIntentTitle().0, url: audioURL)
            MusicPlayer.shared.play()
            let response = PlayPodcastIntentResponse(code: .continueInApp, userActivity: userActivity)
            completion(response)
        }
        PlayPodcastIntentHandler.count += 1
    }
    
    func getURLForIntentTitle() -> (String, String) {
        
        switch PlayPodcastIntentHandler.count {
        case 0:
            return ("Reopening of Schools", "http://api.audm.com/v5/new-yorker-audio-url-mp3?publisher-slug=newyorker&article-id=601c61a5b18004aa38d58f98")
        case 1:
            return ("Among the Insurrectionists", "https://api.audm.com/v5/new-yorker-audio-url-mp3?publisher-slug=newyorker&article-id=601972ae3eaff70e01d1e643")
        case 2:
            return ("The Believer", "https://api.audm.com/v5/new-yorker-audio-url-mp3?publisher-slug=newyorker&article-id=601972a3be123fdd23533251")
        case 3:
            return ("Dream Lover", "https://api.audm.com/v5/new-yorker-audio-url-mp3?publisher-slug=newyorker&article-id=601972db9cfa59d565423867")
        case 4:
            return ("Bruno Schulz", "https://www.podtrac.com/pts/redirect.mp3/audio.wnyc.org/tnyfiction/tnyfiction020122_zambra.mp3")
        case 5:
            return ("Russia’s Intentions", "https://www.podtrac.com/pts/redirect.mp3/audio.wnyc.org/tnyradiohour/tnyradiohour012822_webhour.mp3")
        default:
            return ("Tracy K. Smith", "https://www.podtrac.com/pts/redirect.mp3/audio.wnyc.org/tnypoetry/tnypoetry122221_gorman.mp3")
        }
    }
}
