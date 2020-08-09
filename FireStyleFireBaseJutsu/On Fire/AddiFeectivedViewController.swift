//
//  AddiFeectivedViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/8/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseAuth

class AddiFeectivedViewController: UIViewController {

    var postsHolder = [NSPost]()

    @IBOutlet weak var addiFeectTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        addiFeectTableView.delegate = self
        addiFeectTableView.dataSource = self
        
        freeLoader()

    }
    
    func freeLoader() {
        
        Database.database().reference().child("PostsShared").observe(.childAdded) { (dataSnap: DataSnapshot) in
            // print(Thread.isMainThread)
            guard let snapDictio = dataSnap.value as? [String : Any] else { return }
            guard let picURL = snapDictio["picURL"] as? String else { return }

            let individualPost = NSPost(picURL: picURL)
            self.postsHolder.append(individualPost)
            
            self.addiFeectTableView.reloadData()
        }
    }
}

extension AddiFeectivedViewController {
    
    func fetchPosts() {
        
        Database.database().reference().child("PostsShared").queryOrderedByKey().observeSingleEvent(of: .childAdded) { (dataSnap) in
            guard let snapDictio = dataSnap.value as? [String : Any] else { return }
            guard let picURL = snapDictio["picURL"] as? String else { return }

        }
    }
}

extension AddiFeectivedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cello = addiFeectTableView.dequeueReusableCell(withIdentifier: "cello", for: indexPath) as? AddiFeectivedCello else { print("addifeec cello ain't exist")
            return UITableViewCell.init() }
 
        return cello
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addiFeectTableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    print("postHolder.count = ", postsHolder.count)
        return postsHolder.count
    }
}
