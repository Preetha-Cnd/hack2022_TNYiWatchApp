//
//  SplashScreenViewController.swift
//  TNYWatchApp WatchKit Extension
//
//  Created by Saini, Priyanka on 04/02/22.
//

import WatchKit
import Foundation


class SplashScreenViewController: WKInterfaceController {
    
    @IBOutlet var tableView: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface object
    }
    
    override func willActivate() {
        super.willActivate()
        Timer.scheduledTimer(timeInterval: 2.0 ,
            target: self,
            selector: #selector(self.timerDidEnd),
            userInfo: nil,
            repeats: false)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @objc func timerDidEnd() {
        presentController(withName: "AudioListView", context: nil)
    }
}
