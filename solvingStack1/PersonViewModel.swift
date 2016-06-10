//
//  Manager.swift
//  solvingStack1
//
//  Created by DARI on 6/9/16.
//  Copyright © 2016 DARI. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

struct PersonViewModel {
    
    var person = MutableProperty<Person>(Person())
    
    var birthdateText = MutableProperty<String>("")
    
    var nameText = MutableProperty<String>("")
    
    var email = MutableProperty<String>("")
    
    
    var birthDateTextCorrectSignalProducer: SignalProducer<Bool?, NoError>!
    
    var emailCorrectSignalProducer: SignalProducer<Bool?, NoError>!
    
    var nameCorrectSignalProducer: SignalProducer<Bool?, NoError>!
    
    var correctPersonSignalProducer: SignalProducer<Bool, NoError>!
    
    init(){
        
    }
    
    init (person: Person) {
        self.changeModel(person)
    }
    
    mutating func changeModel(person: Person) {
        self.person.value = person
        
        if person.salutation.characters.count > 0 {
            self.nameText.value = "\(person.salutation) \(person.firstName) \(person.lastName)"
        }else {
            self.nameText.value = "\(person.firstName) \(person.lastName)"
        }
        
        self.birthdateText.value = Static.dateFormatter.stringFromDate(person.dob)
        
        self.email.value = person.email.isEmail ? person.email : ""
    }
    
    mutating func initBinding(){
        birthDateTextCorrectSignalProducer = birthdateText.producer.map({ (text) -> Bool? in
            if text.characters.count > 0 {
             return Static.dateFormatter.dateFromString(text) != nil
            }
            return nil
        })
        emailCorrectSignalProducer = email.producer.map({ (text) -> Bool? in
            if text.characters.count > 0 {
                return text.isEmail
            }
            return nil
        })
        nameCorrectSignalProducer = nameText.producer.map({ (text) -> Bool? in
            if text.characters.count > 0 {
            let names = self.nameText.value.componentsSeparatedByString(" ")
            if names.count == 3 {
                return ["Mr.", "Ms.", "Mrs."].contains(names[0]) && names[1].characters.count > 3 && names[2].characters.count > 3
            }
            return false
            }
            return nil
        })
        correctPersonSignalProducer = combineLatest(emailCorrectSignalProducer, nameCorrectSignalProducer, birthDateTextCorrectSignalProducer).map({(email, name, birthDate) -> Bool in
            if let email = email, let name = name, birthDate = birthDate {
                return email && name && birthDate
            }
            return false
        })
        
        correctPersonSignalProducer.filter { (correct) -> Bool in
            correct
        }.startWithNext { (_) in
            let names = self.nameText.value.componentsSeparatedByString(" ")
            
            self.person.value = Person(salutation: names.first!, firstName: names[1], lastName: names.last!, dob: Static.dateFormatter.dateFromString(self.birthdateText.value)!, email: self.email.value)
        }
    }
}
