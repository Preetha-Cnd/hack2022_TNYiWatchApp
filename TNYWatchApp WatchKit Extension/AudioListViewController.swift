//
//  AudioListViewController.swift
//  TNYWatchApp WatchKit Extension
//
//  Created by Saini, Priyanka on 02/02/22.
//

import WatchKit
import Foundation


class AudioListViewController: WKInterfaceController {
    
    @IBOutlet var tableView: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure inteerface object
        loadTableData()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func loadTableData() {
        tableView.setNumberOfRows(Article.allItems().count, withRowType: "Cell")
        var i = 0
        for item in Article.allItems() {
            let row = tableView.rowController(at: i) as! TableRowObject
            row.listLabel.setText(item.name)
            i = i + 1
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        pushController(withName: "PlayAudioView", context: rowIndex)
    }
    
}































