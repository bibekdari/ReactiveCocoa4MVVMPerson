//
//  ViewController.swift
//  solvingStack1
//
//  Created by DARI on 6/9/16.
//  Copyright © 2016 DARI. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    var viewModel: PersonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.saveButton.enabled = false
        
        viewModel = PersonViewModel()
        
        nameTextField <~ self.viewModel.nameText
        emailTextField <~ self.viewModel.email
        dateOfBirthTextField <~ self.viewModel.birthdateText
    
        
//        self.emailTextField.rac_textSignal().toSignalProducer().startWithNext { (text) in
//            self.viewModel.email.value = text as? String ?? ""
//        }
        
        viewModel.initBinding()
        
        viewModel.nameCorrectSignalProducer.startWithNext({ (correct) in
            self.nameTextField.isValid(correct)
        })
        
        viewModel.birthDateTextCorrectSignalProducer.startWithNext { (correct) in
            self.dateOfBirthTextField.isValid(correct)
        }
        
        
        viewModel.correctPersonSignalProducer.startWithNext {(correct) in
            self.saveButton.enabled = correct
        }
        
        viewModel.emailCorrectSignalProducer.startWithNext { (correct) in
            self.emailTextField.isValid(correct)
        }
        
//        self.viewModel.email.producer.startWithNext { (text) in
//            self.emailTextField.text = text
//        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveButtonTouched(sender: AnyObject) {
        viewModel.email.value = "helllp"
    }
}