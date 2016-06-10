//
//  Helpers.swift
//  solvingStack1
//
//  Created by bibek timalsina on 6/9/16.
//  Copyright © 2016 DARI. All rights reserved.
//

import Foundation
struct Static {
    static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        return formatter
    }()
}