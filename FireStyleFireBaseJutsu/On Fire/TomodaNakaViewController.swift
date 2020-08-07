//
//  TomodaNakaViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/1/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//
import FirebaseDatabase
import UIKit
import Firebase
import FirebaseAuth

class TomodaNakaViewController: UIViewController {
    
    var usersCollection = TargetedFriend() // one layer for simplicity
    // switch to NSUser later
    

    var ref: DatabaseReference? // ?+guard later
    let pUser = Auth.auth().currentUser
    
    var tempStringFriendzList: [String] = []
    
    @IBOutlet weak var targetUsernameTextfield: UITextField!
    @IBOutlet weak var presentFriendzTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentFriendzTable.dataSource = self
        
        newSetUpFriendBoat(targetEmail: "whattheheck@whattheheck.com")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    //    snatchUsers()
    }
    
    
    func newSetUpFriendBoat(targetEmail: String) {
        
        ref = Database.database().reference()
        
        ref?.child("Users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (dSnapshot) in
            let userIDs = dSnapshot.value as! [String:AnyObject]
            

            print("Separator -----------------------")
            for userID in userIDs {
                print("user email is ", userID.value["Email"])
                if targetEmail == userID.value["Email"] as? String {
                    
                    print("user ID . key is" ,userID.key)
                    
                    self.ref?.child("Users").child(userID.key).updateChildValues([ "Friendz": [targetEmail] ])
     
                    
                } else {
                    print("TargetEmail not found")
                }
            }
            
            print("Separator -----------------------")
        })
        
        
        
    }

    
    
    @IBAction func friendshipInitiation(_ sender: UIButton) {
        
        let targetUserName = targetUsernameTextfield.text
        print(targetUserName)
        
        ref = Database.database().reference()
        
        guard let presentUserUID = pUser?.uid else { return }
        
        let friendzList = ref?.observe(.value) { (dataSnap) in
            
            print(dataSnap.childSnapshot(forPath: presentUserUID).childSnapshot(forPath: "Friendz").children.allObjects[0])
            // print(dataSnap)
            print("end of dataSnap")
        }
        print("friendzList is: ", friendzList)
        
        ref?.child(presentUserUID).child("Friendz").observeSingleEvent(of: .value, with: { (dataSnap) in
            if let individualFriend = dataSnap.value as? String {
                print("individual friend's value is \(individualFriend)")
            }
        })
                           
        tempStringFriendzList.append(targetUserName ?? "Imaginary friend")
        
        ref?.child("Users").child(presentUserUID).updateChildValues(["Friendz": tempStringFriendzList], withCompletionBlock: { (erro, databaseReference) in
            print("erro is:", erro?.localizedDescription)
            print(presentUserUID)
            print(self.ref?.childByAutoId())
            print("end of block")
        })

    }

}

//        print(cUser?.email)
// //       setUpFriendboat()
//
//        cUser?.sendEmailVerification(completion: { (erro) in
//            print("email verfi error", erro?.localizedDescription)
//        })

//        ref = Database.database().reference()
//
//        guard let cUserUID = pUser?.uid else { return }
//
//        ref?.child(cUserUID).setValue(["Followers": ["Frank", "Keith"]], withCompletionBlock: { (erro, databaseReference) in
//            print("erro is:", erro?.localizedDescription)
//            print(cUserUID)
//        })
//
//        ref?.observe(.value) { (dataSnap) in
//            print(dataSnap.childSnapshot(forPath: cUserUID).childSnapshot(forPath: "Followers").children.allObjects[1])
//        }
        
        // ref.updateChildValue

//let followersArryRef = ref?.child(cUserUID).child("Followers")
//print("followers are", followersArryRef)

//        ref?.child("collecto").child("elementary").setValue(["element": ["iciness", "itc"]]) { (error, databaseReference) in
//            print("erro is: \(error.debugDescription)")
//
//            print(databaseReference.database.reference())
//        }

//        print("current user is: ", cUser)
//        print(cUser?.photoURL)
//        print(cUser.self)
//        print(cUser?.email)
//        print("UID is: ", cUser?.uid)
//
//        ref.child("collecto").child("C416Ec05gWsUD57lNDdD").setValue(["innateElement": "ocean wave"]) { (error, dBaseRef) in
//            print(error?.localizedDescription)
//            print(dBaseRef.database)
//        }
//
//        ref.child("collecto").child("elementary").setValue(["element": "ice"]) { (error, databaseReference) in
//            print("erro is: \(error.debugDescription)")
//
//            print(databaseReference.database.reference())
//        }
//
//        print(ref.child("collec"))

//ref?.child("collecto").child("C416Ec05gWsUD57lNDdD").observeSingleEvent(of: .value) { (dataSnap) in
//            let value = dataSnap.value as? NSDictionary
//            print("snapValue is:,", value)
//            let element = value?["innateElement"]
//            print("element is", element)
//        }


//        self.tempStringFriendzList = (dataSnap.childSnapshot(forPath: presentUserUID).childSnapshot(forPath: "Friendz").children.allObjects.first
        
        // childByAutoID - 利器
        
//        ref?.child(presentUserUID).setValue(["Friendz": friendzList.append blablabla], withCompletionBlock: { (erro, databaseReference) in
//            print("erro is:", erro?.localizedDescription)
//            print(presentUserUID)
//            print(self.ref?.childByAutoId())
//            print("end of block")
//        })


//tempStringFriendzList.append(targetUserName ?? "Imaginary friend")
//ref?.child(presentUserUID).setValue(["Friendz": tempStringFriendzList], withCompletionBlock: { (erro, datanaseReference) in
//    print("erro is:", erro?.localizedDescription)
//    print(presentUserUID)
//    print(self.ref?.childByAutoId())
//    print("end of block")
//
//})

//    func oldSetUpFriendboat() {
//
//        ref = Database.database().reference()
//        guard let pUserUID = pUser?.uid else { return }
//
//        let userInfoDict = ["UID": pUserUID, "User Name": "MilkyWay", "Friendz": ["Mercury", "Venus", "Mars"], "Friendz Count": 3] as [String : Any]
//
//        ref?.child("Users").child(pUserUID).setValue(userInfoDict)
//        // updateChildValues(userInfoDict)
//
//        print("set up friend boat called")
//    }
