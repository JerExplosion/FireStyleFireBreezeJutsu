//
//  AddiFeectivedCello.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/9/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

protocol ApprovalDelegate {
    func externalValidation(afCell: AddiFeectivedCello)
}

class AddiFeectivedCello: UITableViewCell {
    
    var approvalDelegate: ApprovalDelegate?
  
    @IBOutlet weak var addiFeectivedImagery: UIImageView!
    @IBOutlet weak var addiFeectivedUserName: UILabel!
    @IBOutlet weak var addiFeectivedCaptionLabel: UILabel!
    @IBOutlet weak var addiFeectivedProfilePicture: UIImageView!
    
    @IBOutlet weak var approvalButton: UIButton!
            
    @IBAction func hittingApproval(_ sender: UIButton) {
        approvalDelegate?.externalValidation(afCell: self)
    }
}
