//
// Created by MIGUEL MOLDES on 8/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import XCTest

@testable import TestThoughtWorks

class TWPathCalculatorTest : XCTestCase {

    let timeUnit = 5
    let priceUnit = 1

    func testShouldReturnFastestPath() {
        let provider = makeProvider()

        for check in sameLineCheck {
            let from = provider.stationById(id: check[0])
            let to = provider.stationById(id: check[1])
            let time = check[2] * timeUnit
            let price = check[3] * priceUnit
            let result = makeSUT(provider: provider).calculate(from!, to!)
            XCTAssertEqual(result.price, price)
            XCTAssertEqual(result.time, time)
        }
    }

    func testShouldReturnFastestPathWithStations() {
        let provider = makeProvider()

        for check in sameLineWithStations {
            let from = provider.stationById(id: check["from"] as! Int)
            let to = provider.stationById(id: check["to"] as! Int)
            let stations = check["stations"] as! [Int]
            let result = makeSUT(provider: provider).calculate(from!, to!)
            XCTAssertEqual(result.stations.map{$0.id}, stations)
        }
    }

    func testShouldReturnFastestPathForDifferentLines() {
        let provider = makeProvider()

        
    }



//MARK helpers

    private func makeSUT(provider:TWLinesAndStationsProvider) -> TWPathCalculator {
        return TWFastestPathCalculator(provider:provider)
    }


//Fake data

    let sameLineCheck = [
            [1,2,1,1],
            [1,3,2,2],
            [1,10,9,9],
            [10,1,9,9],
            [2,5,3,3],
            [5,4,1,1],
            [6,6,0,0],
            [1,11,1,1],
            [11,19,8,8],
            [33,9,3,3],
            [34,19,7,7]
    ]

    let sameLineWithStations = [
        [
            "from":1,
            "to":2,
            "stations":[1,2]
        ],
        [
                "from":1,
                "to":4,
                "stations":[1,2,3,4]
        ],
        [
                "from":1,
                "to":14,
                "stations":[1,11,12,13,14]
        ],
        [
                "from":16,
                "to":13,
                "stations":[16,15,14,13]
        ]
    ]

}
