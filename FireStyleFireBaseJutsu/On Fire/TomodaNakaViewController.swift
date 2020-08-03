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
    
    var ref: DatabaseReference? // ?+guard later
    
    let cUser = Auth.auth().currentUser
    
    
    @IBOutlet weak var targetUsernameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }
    
    @IBAction func friendshipInitiation(_ sender: UIButton) {
        
        let targetUserName = targetUsernameTextfield.text
        print(targetUserName)
        
        ref = Database.database().reference()
        
        guard let presentUserUID = cUser?.uid else { return }
        
        let friendzList = ref?.observe(.value) { (dataSnap) in
            print(dataSnap.childSnapshot(forPath: presentUserUID).childSnapshot(forPath: "Friendz").children.allObjects[0])
            print(dataSnap)
        }
        print("friendzList is: ", friendzList)
        
        // childByAutoID - 利器
        
        ref?.child(presentUserUID).setValue(["Friendz": friendzList.append blablabla], withCompletionBlock: { (erro, databaseReference) in
            print("erro is:", erro?.localizedDescription)
            print(presentUserUID)
            print(self.ref?.childByAutoId())
            print("end of block")
        })
    }
    
    
    func setUpFriendboat() {
        
        ref = Database.database().reference()
        
        guard let cUserUID = cUser?.uid else { return }

        ref?.child(cUserUID).setValue(["Followers": ["Frank", "Keith"]], withCompletionBlock: { (erro, databaseReference) in
            print("erro is:", erro?.localizedDescription)
            print(cUserUID)
        })
        

        ref?.observe(.value) { (dataSnap) in
            print(dataSnap.childSnapshot(forPath: cUserUID).childSnapshot(forPath: "Followers").children.allObjects[1])
        }
        // ref.updateChildValue
        
    }
}

//        print(cUser?.email)
// //       setUpFriendboat()
//
//        cUser?.sendEmailVerification(completion: { (erro) in
//            print("email verfi error", erro?.localizedDescription)
//        })


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


