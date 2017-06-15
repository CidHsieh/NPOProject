//
//  MessageModel.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/6/15.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import Foundation

class Message {
    var nickName = ""
    var message = ""
    var time = ""
    init(nickName: String, message: String, time: String) {
        self.nickName = nickName
        self.message = message
        self.time = time
    }
}
