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
        TKSotryVideo(title: "台客劇場》我在愛心尾牙認識的阿伯", subTitle: "台客劇場》我在新年愛心尾牙認識的阿伯 TKstory 這個愛心尾牙是刈包吉（廖榮吉）辦的。新聞稱街友宴會是招待遊民、長者或失業者的免費春酒！這種公益真是令人感動，所以我就來了！", code: "Bg0AxtZ334c"),TKSotryVideo(title: "台客劇場》給外籍看護的母親節禮物", subTitle: "台客劇場 》給外籍看護（阿娣Sunny）的母親節禮物 有一群母親比較沒有被重視。但他們真的很重要！阿娣&Sunny：母親節快樂！", code: "3DO343LGnE4"),TKSotryVideo(title: "台客劇場》婚姻的黑箱秘密 Secrets and Amnesia", subTitle: "發想來至反課綱反黑箱的學生運動。高中生生有勇氣抗議，台客劇場也想表達！歷史書不能代表真相，只是贏家的主觀。但這次也太誇張了吧！", code: "EB10c6qNev4")
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
