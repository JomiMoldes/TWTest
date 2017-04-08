//
// Created by MIGUEL MOLDES on 8/4/17.
// Copyright (c) 2017 MiguelMoldes. All rights reserved.
//

import Foundation

struct TWLine {

    let id : Int
    let name : String
    let stationsOrder : [Int]

    init(id:Int, name:String, order:[Int]) {
        self.id = id
        self.name = name
        self.stationsOrder = order
    }

}
