//
//  FirebaseManager.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/10/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

typealias completionHandler = ((DataSnapshot) -> ())?

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() { }
    
    func fetchPosts(childID: String, child: String, compHandle: completionHandler) {
        Database.database().reference().child(child).queryOrderedByKey().observeSingleEvent(of: .childAdded) { (dataSnap) in   //   "PostsShared"
            compHandle?(dataSnap)
        }
    }
    
}
         
