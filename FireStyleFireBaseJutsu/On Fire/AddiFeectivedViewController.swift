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

class AddiFeectivedViewController: UIViewController {

    var postsHolder = [NSPost]()
    
    var approved = false

    @IBOutlet weak var addiFeectTableView: UITableView!
    
    @IBOutlet weak var horizontalCollectV: UICollectionView!
         
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    rotator(animaDelay: 0.5)
  
        addiFeectTableView.delegate = self
        addiFeectTableView.dataSource = self
        
        horizontalCollectV.delegate = self
        horizontalCollectV.dataSource = self
        
        horizontalCollectV.layer.borderColor = UIColor.lightGray.cgColor
        horizontalCollectV.layer.borderWidth = 0.5
        
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
            
            let likes = snapDictio["likes"]  as? Int ?? 36
            
            let individualPost = NSPost(picURL: picURL, poster: poster, caption: caption, likes: likes)
            self.postsHolder.append(individualPost)
            
            self.postsHolder.reverse() 
            
            self.addiFeectTableView.reloadData()
        }
        freeLoaderRef.removeAllObservers()
    }
}

extension AddiFeectivedViewController {
    
    func fetchPosts() {
        
        FirebaseManager.shared.fetchPosts(childID: "", child: "PostsShared", compHandle: { (dataSnap) in
            guard let snapDictio = dataSnap.value as? [String : Any] else { return }
            guard let picURL = snapDictio["picURL"] as? String else { return }
            guard let caption = snapDictio["caption"] as? String else { return }
            
            self.addiFeectTableView.reloadData()
        })
    } // decent start of refactorization but fetchPosts ain't used anywhere yet
}
        
extension AddiFeectivedViewController: TableDatasourceDelegateCombination {
    
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

        guard let cello = tableView.dequeueReusableCell(withIdentifier: "cello", for: indexPath) as? AddiFeectivedCello else { print("addifeec cello ain't exist")
            return UITableViewCell.init() }
        
        cello.approvalDelegate = self
        
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
        })
        // newer cache technique to improve speed of fetching
        
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
            return  530
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addiFeectTableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsHolder.count
    }
}

extension AddiFeectivedViewController: ApprovalDelegate {
     
    func externalValidation(afCell: AddiFeectivedCello) {
        
        guard var btoImgString = ( (approved == true) ? "like-aka" : "like-ios" )
            else { return }
        let btoImg = UIImage(named: btoImgString)
        afCell.approvalButton.setImage(btoImg, for: .normal)
        approved = !approved
    }
}
