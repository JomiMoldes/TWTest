//
// Created by MIGUEL MOLDES on 8/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation

class TWLinesAndStationsProvider {

    let stations : [TWStation]
    let lines : [TWLine]
    private var stationsDic = [Int:TWStation]()
    private var linesDic = [Int:TWLine]()

    init(stations:[TWStation], lines: [TWLine]) {
        self.stations = stations
        self.lines = lines
        parseByIds()
    }

    func lineBy(id:Int) -> TWLine? {
        return linesDic[id]
    }

    func stationById(id:Int) -> TWStation? {
        return stationsDic[id]
    }

    func sharedLine(_ from:TWStation,_ to: TWStation) -> TWLine? {
        let common = Set(from.lines).intersection(Set(to.lines))
        if let first = common.first {
            return lineBy(id: first)
        }
        return nil
    }

    /*func connectionsForStation(_ station:TWStation) -> [TWStation] {
        var connections = [TWStation]()
        let lines = station.lines.flatMap{lineBy(id: $0)}
        for line in lines {
            let allStations = line.stationsOrder.flatMap{stationById(id: $0)}.filter{$0.id != station.id && $0.lines.count > 1}
            connections.append(contentsOf: allStations)
        }
        return connections
    } */

    func connectionsForStationByLine(_ station:TWStation, line:TWLine) -> [TWStation] {
        guard line.stationsOrder.index(of:station.id) != nil else {
            return []
        }
        return line.stationsOrder.flatMap{stationById(id: $0)}.filter{$0.id != station.id && $0.lines.count > 1}
    }

    private func parseByIds() {
        for line in lines {
            linesDic[line.id] = line
        }
        for station in stations {
            stationsDic[station.id] = station
        }
    }

}
