//
//  CurrentFriendzTable.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/3/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Firebase
import FirebaseDatabase
import UIKit
                   
extension TomodaNakaViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cello = presentFriendzTable.dequeueReusableCell(withIdentifier: "fCell", for: indexPath)
        cello.textLabel?.text = "Julianne"
        
        cello.textLabel?.font = UIFont(name: "Georgia", size: 16)
        
        return cello
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
}

extension TomodaNakaViewController {
    
    // 参见 retrieve()
    func snatchUsers() {
        
        let reference = Database.database().reference()
        
        ref?.queryOrderedByKey().observeSingleEvent(of: .value, with: { (dataSnap) in
            let users = dataSnap.value as! [String: AnyObject]
            
            print("users are: ")
            print(users)
            
            for (key, value) in users {
                let uID = value["userID"] as? String
                
                if uID != self.pUser?.uid {
                      
                    let userToBeShown = TargetedFriend()
                    userToBeShown.fuame = value["friendzName"] as? String  // construct data structure
                    userToBeShown.userID = value["userID"] as? String
                    // blabla
                }
            }
        })
        self.presentFriendzTable.reloadData()
    }
    
}
