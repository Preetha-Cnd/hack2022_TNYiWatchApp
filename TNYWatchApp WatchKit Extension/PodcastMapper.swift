//
//  PodcastMapper.swift
//  TNYWatchApp WatchKit Extension
//
//  Created by Saini, Priyanka on 02/02/22.
//

import Foundation
import WatchKit

class PodcastMapper: Decodable {
    
    public var articleName: String
    public var podcastStreamingURL: String
    
    init(articleName: String,
         podcastStreamingURL: String) {
        
        self.articleName = articleName
        self.podcastStreamingURL = podcastStreamingURL
    }
}
