//
//  NSPost.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/8/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Foundation

class NSPost {
    
    var picURL: String
    var poster: String
    var caption: String
    var likes: Int
    
    init(picURL: String, poster: String, caption: String, likes: Int) {
        self.picURL = picURL
        self.poster = poster
        self.caption = caption
        self.likes = likes
    }
        
}
