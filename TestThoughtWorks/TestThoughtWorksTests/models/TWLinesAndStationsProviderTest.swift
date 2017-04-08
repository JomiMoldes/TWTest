import Foundation
import XCTest

@testable import TestThoughtWorks

class TWLinesAndStationsProviderTest : XCTestCase {

    

    func testShouldProvideStations() {
        let sut = makeSUT()
        XCTAssertEqual(sut.stations.count, 38)
        XCTAssertEqual(sut.lines.count, 5)
    }

    func testShouldProvideLineById() {
        let sut = makeSUT()

        let line = sut.lineBy(id:1)
        XCTAssertEqual(line?.name, "Blue line")

        let line5 = sut.lineBy(id:5)
        XCTAssertEqual(line5?.name, "Red line")

        let lineNil = sut.lineBy(id:0)
        XCTAssertNil(lineNil)
    }

    func testShouldReturnStationById() {
        let sut = makeSUT()
        let station1 = sut.stationById(id:1)
        XCTAssertEqual(station1?.name, "East end")

        let stationNil = sut.stationById(id: 0)
        XCTAssertNil(stationNil)

        let station38 = sut.stationById(id: 38)
        XCTAssertEqual(station38?.name, "Trinity lane")
    }



//MARK helpers

    private func makeSUT() -> TWLinesAndStationsProvider {
        let data = jsonLoader().load(fileName: "stations_test")
        let stations = TWStationsParser().parse(data)
        let lines = TWLinesParser().parse(data)
        return TWLinesAndStationsProvider(stations: stations, lines: lines)
    }

}
