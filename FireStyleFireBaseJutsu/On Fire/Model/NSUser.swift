//
//  NSUser.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/3/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

struct NSUser {
         // switch to struct later (so that noinitializers needed), but can't inherit NSObject
    var userID: String
    var friendzList: [TargetedFriend]
    var friendzNumber: Int
    var uame: String
}

class TargetedFriend: NSObject { // is NSObject necessary here though
    var userID: String! // change to question-mark later
    var fuame: String!
}
     
