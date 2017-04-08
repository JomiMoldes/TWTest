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


        return TWPathResult(time: 0, price: 0, stations:[])
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
            stationsIds = Array(order[toIndex...fromIndex])
            stationsIds = stationsIds.reversed()
        } else {
            stationsIds  = Array(order[fromIndex...toIndex])
        }

        let stations = stationsIds.map{
            provider.stationById(id: $0)
        }.flatMap { $0 }

        return TWPathResult(time: stationsCount * 5, price: stationsCount * 1, stations:stations)
    }

    private func calculateDifferentLines(_ from:TWStation,_ to:TWStation) -> TWPathResult {

        return TWPathResult(time: 1, price: 1, stations: [])
    }

}
