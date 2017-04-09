//
// Created by MIGUEL MOLDES on 8/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation

class TWFastestPathCalculator : TWPathCalculator {

    let provider : TWLinesAndStationsProvider

    init(provider:TWLinesAndStationsProvider) {
        self.provider = provider
    }


    func calculate(_ from:TWStation,_ to:TWStation) -> TWPathResult {
        if let commonLine = provider.sharedLine(from, to) {
            return calculateSameLine(from, to, commonLine)
        }

        return calculateDifferentLines(from, to)
    }

    private func calculateSameLine(_ from:TWStation,_ to:TWStation, _ line:TWLine) -> TWPathResult {
        let order = line.stationsOrder
        guard let fromIndex = order.index(of:from.id),
            let toIndex = order.index(of:to.id) else {
            fatalError("stations don't share this line")
        }
        
        let stationsCount = abs(toIndex - fromIndex)
        var stationsIds = [Int]()
        if fromIndex > toIndex {
            stationsIds = Array(order[toIndex...fromIndex]).reversed()
        } else {
            stationsIds  = Array(order[fromIndex...toIndex])
        }

        let stations = stationsIds.map{ provider.stationById(id: $0) }.flatMap { $0 }

        return TWPathResult(time: stationsCount * 5, price: stationsCount * 1, stations:stations)
    }

    private func calculateDifferentLines(_ from:TWStation,_ to:TWStation) -> TWPathResult {
        
        var fromConnections:[NextStation] = connectionsByStation(from)
        let toConnections = connectionsByStation(to)
        fromConnections = orderByMatches(fromConnections, toConnections)

        var stationsAmount = 0
        for station in fromConnections {
            var q = station.distance
            if let sharedLine = provider.sharedLine(station.station, to) {
                q += distanceBetweenTwoStationsInSameLine(station.station, to, sharedLine)
                stationsAmount = q < stationsAmount || stationsAmount == 0 ? q : stationsAmount
                continue
            }
            var ownFromConnections = connectionsByStation(station.station)
            ownFromConnections = orderByMatches(ownFromConnections, toConnections)

            for connection in ownFromConnections {
                var q2 = connection.distance
                var total = q + q2
                if total >= stationsAmount && stationsAmount > 0 {
                    continue
                }
                if let sharedLine = provider.sharedLine(connection.station, to) {
                    q2 += distanceBetweenTwoStationsInSameLine(connection.station, to, sharedLine)
                    total = q + q2
                    stationsAmount = total < stationsAmount || stationsAmount == 0 ? total : stationsAmount
                    continue
                }
            }
        }

        return TWPathResult(time: stationsAmount * 5, price: stationsAmount * 1, stations: [])
    }

    private func orderByMatches(_ fromConnections:[NextStation],_ toConnections:[NextStation]) -> [NextStation] {
        let matches = sharedConnections(fromConnections, toConnections)

        return fromConnections.sorted{ from, to in
            let id = from.station.id
            for match in matches {
                if match.station.id == id {
                    return true
                }
            }
            return false
        }
    }

    private func sharedConnections(_ fromConnections:[NextStation],_ toConnections:[NextStation]) -> [NextStation] {
        let matches = toConnections.filter {
            for station in fromConnections {
                if station.station.id == $0.station.id {
                    return true
                }
            }
            return false
        }

        return matches
    }

    private func connectionsByStation(_ from:TWStation) -> [NextStation] {
        var allConnections = [NextStation]()
        let lines = from.lines.map{ provider.lineBy(id: $0) }.flatMap { $0 }

        for line in lines {
            let connections = provider.connectionsForStationByLine(from, line: line)
            for connection in connections {
                let distance = distanceBetweenTwoStationsInSameLine(from, connection, line)
                let nextStation = NextStation(station: connection, line: line, distance: distance)
                allConnections.append(nextStation)
            }
        }
        return allConnections.sorted{$0.distance < $1.distance}
    }

    private func distanceBetweenTwoStationsInSameLine(_ from:TWStation, _ to:TWStation, _ line:TWLine) -> Int {
        let order = line.stationsOrder
        guard let fromIndex = order.index(of:from.id),
              let toIndex = order.index(of:to.id) else {
            fatalError("stations don't share this line")
        }

        return abs(toIndex - fromIndex)
    }

}

struct NextStation {

    var station : TWStation
    var line : TWLine
    var distance : Int

    init(station:TWStation, line:TWLine, distance:Int){
        self.station = station
        self.line = line
        self.distance = distance
    }

}
