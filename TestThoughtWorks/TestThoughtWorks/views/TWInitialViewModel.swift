//
// Created by MIGUEL MOLDES on 9/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TWInitialViewModel {

    let fromInputYMultiplier:CGFloat = 0.6
    let toInputYMultiplier:CGFloat = 0.9
    let buttonYMultiplier:CGFloat = 0.8

    let updateConstraintsSubject = PublishSubject<Bool>()

    let fromInputModel : TWInputStationViewModel
    let toInputModel : TWInputStationViewModel

    init() {
        fromInputModel = TWInputStationViewModel(provider:TWGlobalModels.sharedInstance.stationsProvider)
        toInputModel = TWInputStationViewModel(provider:TWGlobalModels.sharedInstance.stationsProvider)
        addObservers()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue != nil {
            updateConstraintsSubject.onNext(true)
        }
    }

}
