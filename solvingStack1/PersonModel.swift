//
//  PersonModel.swift
//  solvingStack1
//
//  Created by bibek timalsina on 6/9/16.
//  Copyright © 2016 DARI. All rights reserved.
//

import Foundation
struct Person {
    let salutation: String
    let firstName: String
    let lastName: String
    let dob: NSDate
    let email: String
    
    init( salutation: String, firstName: String, lastName: String, dob: NSDate, email: String) {
        self.salutation = salutation
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.email = email
    }
    
    init() {
        self.salutation = ""
        self.firstName = ""
        self.lastName = ""
        self.dob = NSDate()
        self.email = ""
    }
}