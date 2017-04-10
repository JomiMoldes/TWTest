//
// Created by MIGUEL MOLDES on 10/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import XCTest

@testable import TestThoughtWorks

class TWLinesAndStationsProviderFake : TWLinesAndStationsProvider {

    var searchExpectation : XCTestExpectation?
    var stationsFound : [TWStation]?

    override func stationByWord(_ withStart: String, completion: @escaping ([TWStation]) -> ()) {
        super.stationByWord(withStart, completion: {
            stations in
            self.stationsFound = stations
            self.searchExpectation?.fulfill()
        })
    }


}
