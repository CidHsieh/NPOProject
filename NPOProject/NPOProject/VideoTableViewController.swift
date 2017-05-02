//
//  VideoTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/1.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class VideoTableViewController: UITableViewController {
    
    var video:[TKSotryVideo] = [
        TKSotryVideo(title: "台客劇場》我在愛心尾牙認識的阿伯", code: "Bg0AxtZ334c"),TKSotryVideo(title: "台客劇場》給外籍看護的母親節禮物", code: "3DO343LGnE4"),TKSotryVideo(title: "台客劇場》進階淨灘", code: "esSaxV9FiFg"),TKSotryVideo(title: "台客劇場》網友淨灘出擊！謝謝大家這麼愛台灣", code: "9oVDIMEXTFk"),TKSotryVideo(title: "台客劇場》我當街友的那一晚", code: "bj-Rr3m3Ftg")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = "台客劇場"
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return video.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoTableViewCell
        cell.videoTitle.text = video[indexPath.row].title
        cell.videoWebView.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(video[indexPath.row].code)")!))
        return cell
    }
}
