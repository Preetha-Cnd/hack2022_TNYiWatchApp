//
//  IntentHandler.swift
//  PodcastIntent
//
//  Created by S, Preetha on 08/02/22.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is PlayPodcastIntent {
            return PlayPodcastIntentHandler()
        }
        
        return self
    }
}
