//
//  ImageryPull.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/9/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func imageryPull( picURL: String) {
        guard let picURL = URL(string: picURL) else { return }
        let picURLRequest = URLRequest(url: picURL)
        
        URLSession.shared.dataTask(with: picURLRequest) { (data, response, erro) in
            if erro != nil {
                print("Imagery pulling failed ", erro?.localizedDescription)
                return
            }
            guard let picData = data else {
                print("Imagery data failed ")
                return }
            DispatchQueue.main.async {
                self.image = UIImage(data: picData)
            }
        }
        .resume()
    }
}

