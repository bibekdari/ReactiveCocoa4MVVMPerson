//
//  UIKitExtension.swift
//  solvingStack1
//
//  Created by bibek timalsina on 6/9/16.
//  Copyright © 2016 DARI. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

func <~ (textField: UITextField, property: MutableProperty<String>) {
    textField.text = property.value
    
    property <~ textField.rac_bind()
    
    property.producer.startWithNext { [weak textField] (text) in
        textField?.text = text
    }
}

extension UITextField {
    func rac_bind() -> SignalProducer<String, NoError> {
        return self.rac_textSignal().toSignalProducer().map { (text) -> String in
            return text as? String ?? ""
            }.flatMapError { _ in
                SignalProducer<String, NoError>.empty
        }
    }
    
    func isValid(valid: Bool?){
        
        func setImage(verified: Bool) {
            let imagename = verified ? "verified" : "unverified"
            let imageview = UIImageView(image: UIImage(named: imagename))
            self.rightView = imageview
        }
        
        switch valid {
        case .None:
            if let _ = self.rightView{
                setImage(false)
            }
        case .Some(let valid):
            self.rightViewMode = .Always
            setImage(valid)
        }
        //        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        //        activityIndicator.hidesWhenStopped = true
        //        activityIndicator.startAnimating()
        //        self.rightView = activityIndicator
    }
}