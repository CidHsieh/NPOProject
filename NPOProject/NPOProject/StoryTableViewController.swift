//
//  StoryTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import FBSDKShareKit

class StoryTableViewController: UITableViewController {
    let stor = Story()
    let lessonsArray = ["台灣各個社區裡都有一個這樣的阿嬤",
                        "輪椅販賣者，楊姐姐",
                        "賣八寶粥的王太太",
                        "賣桑椹的82歲老奶奶",
                        "賣大誌雜誌的伯伯",
                        "現在年輕學子在想什麼？十年後他們將..."
    ]
    let subtitleArray = ["我們走在四平街陽光商圈中，手中還拿著剛喝完的咖啡罐，碰巧看到一位阿嬤在前方收拾回收品...","飄著雨的傍晚，楊姊姊獨自坐在捷運的出口販賣商品，她是曾被「好事地圖」報導過的輪椅街賣者...","賣八寶粥的王太太，清晨6點就開始備料，煮好一天販賣的量就要四個鐘頭，中午忙著配送公司訂單....","捷運站旁的陰影處，坐在一桶桑葚旁的奶奶正忙著用塑膠盒分裝桑葚，埋頭苦幹的同時四處張望著有沒有客人...","伯伯說，過去發生意外手腳斷過，所以無法正常工作，後來又罹患口腔癌，會發出非常惡臭的氣味...","你還停留在現在年經人都是禁不起考驗的草莓族，或冰塊族嗎？實際街頭探訪，我們發現其實不盡然"]
    
    let photoArray = ["0","1","2","3","4","5"]
    
    var video:[TKSotryVideo] = [
        TKSotryVideo(title: "我在愛心尾牙認識的阿伯", subTitle: "台客劇場》我在新年愛心尾牙認識的阿伯 TKstory 這個愛心尾牙是刈包吉（廖榮吉）辦的。新聞稱街友宴會是招待遊民、長者或失業者的免費春酒！這種公益真是令人感動，所以我就來了！", code: "Bg0AxtZ334c"),TKSotryVideo(title: "給外籍看護的母親節禮物", subTitle: "台客劇場 》給外籍看護（阿娣Sunny）的母親節禮物 有一群母親比較沒有被重視。但他們真的很重要！阿娣&Sunny：母親節快樂！", code: "3DO343LGnE4"),TKSotryVideo(title: "婚姻的黑箱秘密", subTitle: "發想來至反課綱反黑箱的學生運動。高中生生有勇氣抗議，台客劇場也想表達！歷史書不能代表真相，只是贏家的主觀。但這次也太誇張了吧！", code: "EB10c6qNev4")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "故事牆"
        
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        //移除tableView分隔線
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return lessonsArray.count
        } else {
            return video.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! StoryOneTableViewCell
            cell1.storyImageView.image = UIImage(named: "\(indexPath.row)")
            cell1.storyTitle.text = lessonsArray[indexPath.row]
            cell1.storySubTitle.text = subtitleArray[indexPath.row]
            return cell1
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! StoryTwoTableViewCell
            cell2.webView.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(video[indexPath.row].code)")!))
            cell2.videoTitle.text = video[indexPath.row].title
            cell2.videoSubTitle.text = video[indexPath.row].subTitle
            return cell2
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            pushViewController.tempTitle = "\(lessonsArray[indexPath.row])"
            
            pushViewController.index = "\(indexPath.row)"
            
            pushViewController.tempText = stor.story[indexPath.row]
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
   
}
