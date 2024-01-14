//
//  Todo.swift
//  voiceMemo
//

import Foundation

struct Todo : Hashable {
    var title : String
    var time : Date
    var day : Date
    var selected : Bool
    
    var convertedDayAndTime : String {
        // 오늘 - 오후 03:00에 알림
        String("\(day.formattedDay) - \(time.formattedTime)에 알림")
    }
}
