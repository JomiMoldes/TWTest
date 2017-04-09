//
// Created by MIGUEL MOLDES on 9/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import TestThoughtWorks

class TWInitialViewTest : XCTestCase  {

    var view : TWInitialView!
    var model : TWInitialViewModel!

    func testView() {
        view = makeSUT()
        view.model = TWInitialViewModel()
        XCTAssertNotNil(view.model)
        
    }


// helpers

    private func makeSUT() -> TWInitialView {
        return Bundle.main.loadNibNamed("TWInitialView", owner: self)?[0] as! TWInitialView
    }

}
