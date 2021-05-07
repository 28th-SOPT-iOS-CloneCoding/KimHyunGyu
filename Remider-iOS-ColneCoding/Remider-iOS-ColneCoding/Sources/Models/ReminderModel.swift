//
//  ReminderModel.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/04.
//

import Foundation
import RealmSwift

class ReminderModel: Object {
    @objc dynamic var reminderTtile: String = ""
    @objc dynamic var reminderColor: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var memo: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var repeatReminder: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var priority: String = ""
    @objc dynamic var done: Bool = false
}
