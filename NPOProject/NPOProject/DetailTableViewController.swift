//
//  DetailTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/4/28.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var intro: UILabel!
    var movie = [["name": "拆彈專家", "intro": "章在山（劉德華 飾）是香港『爆炸品處理課』（EOD –Explosive Ordnance Disposal Bureau）的一名高級督察。七年前，他作為臥底探員潛伏到頭號通緝犯洪繼鵬外號「火爆」（姜武 飾）的犯罪集團中，並成功瓦解火爆所屬的犯罪集團，共拘捕了包含火爆的弟弟阿標（王紫逸 飾）在內的幾位劫匪，但行動過程中卻意外地讓火爆脫逃並揚言必定會回來報仇。七年後，火爆開始了他的復仇計劃，接連不斷的炸彈驚魂，使全香港市民人心惶惶。為維持法紀，必須將火爆繩之以法，章在山將自己的生命豁出去，和火爆決一死戰……"], ["name": "柯羅索巨獸", "intro": "拯救世界，是我唯一能做的！禍不單行的柯羅莉亞（安海瑟薇 飾演），不僅失業超過一年，再加上被男友提姆（丹史蒂文斯飾演）給甩了、沒錢沒地方住，集結悲慘於一生的魯蛇人生，被迫離開紐約生活再次回到家鄉的她，再次和童年玩伴奧斯卡（傑森蘇戴西斯 飾演）重逢，天天和奧斯卡的朋友們喝酒玩樂過日子。 某天，她在電視上看見首爾遭到巨型怪獸柯羅索攻擊的新聞，原本不以為意的她，竟發現自己和這隻怪獸有著神祕的連結，柯羅莉亞驚覺自己擁有遠端操控柯羅索的能力，眼看事情開始慢慢失控，首爾城市陷入世界災難，柯羅莉亞必須在這事件中找出真相，好了解究竟人生面臨谷底的自己，為何成為決定世界存亡的唯一關鍵？"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 50
        
        name.text = movie[0]["name"]
        intro.text = movie[0]["intro"]
    }



    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            return 100
            
        }
    }
}
