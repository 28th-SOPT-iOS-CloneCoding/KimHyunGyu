//
//  ListModel.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/04.
//

import Foundation
import RealmSwift

class ListModel: Object {
    @objc dynamic var reminderTitle: String = ""
    @objc dynamic var reminderColor: String = ""
    @objc dynamic var num: Int = 0
}

