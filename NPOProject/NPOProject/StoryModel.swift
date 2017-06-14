//
//  StoryModel.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/6/13.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import Foundation

class Storys {
    var latitude = 0.0
    var longitude = 0.0
    var description = ""
    var title = ""
    var user = ""
    var url = ""
    
    init(latitude: Double, longitude: Double, description: String, title: String, user: String, url: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
        self.title = title
        self.user = user
        self.url = url
    }
}
