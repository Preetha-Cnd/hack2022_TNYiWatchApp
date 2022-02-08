//
//  AudioViewController.swift
//  TNYWatchApp

import Foundation
import UIKit

class AudioViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var audioNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension AudioViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Article.allItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AudioTableViewCell else { return UITableViewCell() }
        cell.audioLabel.text = Article.allItems()[indexPath.row].name
        return cell
    }
}
