//
// Created by MIGUEL MOLDES on 9/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TWInitialView : UIView {
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var fromView: TWInputStationView!
    @IBOutlet weak var toView: TWInputStationView!
    
    @IBOutlet weak var buttonYConstraint: NSLayoutConstraint!
    @IBOutlet weak var toStationYConstraint: NSLayoutConstraint!
    @IBOutlet weak var fromStationYConstraint: NSLayoutConstraint!

    let disposable = DisposeBag()

    var model : TWInitialViewModel! {
        didSet {
            self.bind()
            self.setup()
        }
    }

    private func bind() {
        model.updateConstraintsSubject.asObservable()
                .subscribe(onNext:{ [unowned self] _ in
                    self.moveFieldsToTop()
                })
                .addDisposableTo(disposable)

        model.pathFoundSubject.asObservable()
                .subscribe(onNext:{ [unowned self] (result:TWPathResult) in
                    print(result.time)
                })
                .addDisposableTo(disposable)

    }

    private func setup() {
        fromView.model = model.fromInputModel
        toView.model = model.toInputModel
    }

    private func moveFieldsToTop() {
        let newToYConstraint = toStationYConstraint.constraintWithMultiplier(multiplier: model.toInputYMultiplier)
        toStationYConstraint.isActive = false
        self.addConstraint(newToYConstraint)
        toStationYConstraint = newToYConstraint

        let newFromYConstraint = fromStationYConstraint.constraintWithMultiplier(multiplier: model.fromInputYMultiplier)
        fromStationYConstraint.isActive = false
        self.addConstraint(newFromYConstraint)
        fromStationYConstraint = newFromYConstraint

        let newButtonYConstraint = buttonYConstraint.constraintWithMultiplier(multiplier: model.buttonYMultiplier)
        buttonYConstraint.isActive = false
        self.addConstraint(newButtonYConstraint)
        buttonYConstraint = newButtonYConstraint

        self.layoutIfNeeded()
    }

// IBActions

    @IBAction func searchTapped(_ sender: UIButton) {
        _ = model.searchTapped()
    }
    

}
