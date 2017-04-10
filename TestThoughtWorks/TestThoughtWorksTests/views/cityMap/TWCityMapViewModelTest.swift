//
// Created by MIGUEL MOLDES on 10/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import XCTest

@testable import TestThoughtWorks

class TWCityMapViewModelTest : XCTestCase {

    func testResult() {
        let stations = [TWStationPath(station:TWStation(id: 1, name: "East End", lines: [1]), line: TWLine(id: 1, name: "Blue", order: [1,2]))]
        let result = TWPathResult(time: 1, price: 1, stations: stations)
        let sut = TWCityMapViewModel(provider:makeProvider())
        sut.result = result
        XCTAssertNotNil(sut.result)
    }

}
