//
// Created by MIGUEL MOLDES on 9/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import UIKit

class TWInitialView : UIView {

    var model : TWInitialViewModel! {
        didSet {
            self.bind()
            self.setup()
        }
    }

    private func bind() {

    }

    private func setup() {
        
    }

    


}
