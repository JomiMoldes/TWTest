//
// Created by MIGUEL MOLDES on 10/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TWInputStationViewModel {

    let provider : TWLinesAndStationsProvider

    let updateTableSubject = PublishSubject<[TWStation]>()

    init(provider:TWLinesAndStationsProvider) {
        self.provider = provider
    }

    func textHasChanged(str:String) {
        self.provider.stationByWord(str, completion: {
            stations in
            self.updateTableSubject.onNext(stations)
        })
    }
    



}
