//
//  AddiFeectivedViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/8/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import ViewAnimator
import UIKit

import FirebaseDatabase
import FirebaseAuth

class AddiFeectivedViewController: VelocityAnimaViewController {

    var postsHolder = [NSPost]()

    @IBOutlet weak var addiFeectTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        addiFeectTableView.delegate = self
        addiFeectTableView.dataSource = self
        
        freeLoader()
    }

    func freeLoader() {
        
        let freeLoaderRef = Database.database().reference()
        
        freeLoaderRef.child("PostsShared").queryOrderedByKey().observe(.childAdded) { (dataSnap: DataSnapshot) in
            // print(Thread.isMainThread)
            guard let snapDictio = dataSnap.value as? [String : Any] else { return }
            guard let picURL = snapDictio["picURL"] as? String else { return }
            let poster = snapDictio["poster"] as? String ?? "Kingsley" // "Nintendo"
            let caption = snapDictio["caption"] as? String ?? "Placeholder Caption"
            
            let individualPost = NSPost(picURL: picURL, poster: poster, caption: caption)
            self.postsHolder.append(individualPost)
            
            self.postsHolder.reverse() 
            
            self.addiFeectTableView.reloadData()
        }
        freeLoaderRef.removeAllObservers()
    }
}

extension AddiFeectivedViewController {
    
    func fetchPosts() {
        
        FirebaseManager.shared.fetchPosts(childID: "PostsShared", compHandle: { (dataSnap) in
            guard let snapDictio = dataSnap.value as? [String : Any] else { return }
            guard let picURL = snapDictio["picURL"] as? String else { return }
            guard let caption = snapDictio["caption"] as? String else { return }
            
            self.addiFeectTableView.reloadData()
        })
    } // decent start of refactorization but fetchPosts ain't used anywhere yet
}
        
extension AddiFeectivedViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { // willDisplay
//
//        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
//        let zoomAnimation = AnimationType.zoom(scale: 0.2)
//        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
//        UIView.animate(views: tableView.visibleCells,
//                       animations: [zoomAnimation],
//                       duration: 5)
////        UIView.animate(views: tableView.visibleCells,
////                       animations: [fromAnimation, zoomAnimation],
////                       delay: 3)
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        print(postsHolder.count)
        // use tableView instad of myTable
        guard let cello = tableView.dequeueReusableCell(withIdentifier: "cello", for: indexPath) as? AddiFeectivedCello else { print("addifeec cello ain't exist")
            return UITableViewCell.init() }
        
        let thisSpecificPost = postsHolder[indexPath.row]
        let poster = thisSpecificPost.poster
        let imageryCaption = thisSpecificPost.caption
        
        let imageryURLString = thisSpecificPost.picURL
        let imageryURL = URL(string: imageryURLString)
        let imageryURLRequest = URLRequest(url: imageryURL!)
        
        
        // MARS:
        
        ImageryCache.shared.fetchImigi(url: imageryURL!, callBack: {
            (image) in
            cello.addiFeectivedImagery.image = image
            print("image cache called")
        })
        // newer cache technique to improve peed of fetching
        
        // MARS: -
        
  
 //       cello.addiFeectivedImagery.imageryPull( picURL: imageryURLString)
        // (older way - works but performance not maximized)
           
        cello.addiFeectivedUserName.text = poster
        cello.addiFeectivedCaptionLabel.text = imageryCaption
        let pikachuGIF = UIImage.gifImageWithName("SurprisedPikachu")
        cello.addiFeectivedProfilePicture.image = pikachuGIF
        

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
