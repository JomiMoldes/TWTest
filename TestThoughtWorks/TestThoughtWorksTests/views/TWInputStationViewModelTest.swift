//
// Created by MIGUEL MOLDES on 10/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import XCTest

@testable import TestThoughtWorks

class TWInputStationViewModelTest : XCTestCase {


    func testProvider() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.provider)
    }


// helpers

    private func makeSUT() -> TWInputStationViewModel {
        return TWInputStationViewModel(provider:makeProvider())
    }

}
