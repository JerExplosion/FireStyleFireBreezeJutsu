//
//  IsValidEmailOrNaw.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 9/17/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Foundation

extension String {
    var isValidEmailOrNaw: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}



