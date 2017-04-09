//
// Created by MIGUEL MOLDES on 9/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import UIKit

class TWInputStationView : TWDesignableView {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func xibSetup() {
        nibName = "TWInputStationView"
        super.xibSetup()
        hideTables()
    }

    private func hideTables() {
        tableView.isHidden = true
    }
}
