//
// Created by MIGUEL MOLDES on 9/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import UIKit

class TWInitialView : UIView {
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var fromView: TWInputStationView!
    @IBOutlet weak var toView: TWInputStationView!
    
    @IBOutlet weak var buttonYConstraint: NSLayoutConstraint!
    @IBOutlet weak var toStationYConstraint: NSLayoutConstraint!
    @IBOutlet weak var fromStationYConstraint: NSLayoutConstraint!

    var model : TWInitialViewModel! {
        didSet {
            self.bind()
            self.setup()
        }
    }

    private func bind() {

    }

    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
    }

    func keyboardWillShow(_ notification:Notification) {
        if (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue != nil {
//            let keyboardHeight = keyboardSize.height

            let newToYConstraint = toStationYConstraint.constraintWithMultiplier(multiplier: model.toInputYMultiplier)
            toStationYConstraint.isActive = false
            self.addConstraint(newToYConstraint)
            toStationYConstraint = newToYConstraint

            let newFromYConstraint = fromStationYConstraint.constraintWithMultiplier(multiplier: model.fromInputYMultiplier)
            fromStationYConstraint.isActive = false
            self.addConstraint(newFromYConstraint)
            fromStationYConstraint = newFromYConstraint

            let newButtonYConstraint = buttonYConstraint.constraintWithMultiplier(multiplier: model.buttonYMultiplier)
            buttonYConstraint.isActive = false
            self.addConstraint(newButtonYConstraint)
            buttonYConstraint = newButtonYConstraint
            
            
            self.layoutIfNeeded()
        }
    }





}
