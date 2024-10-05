//
//  today.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import Foundation

func today() -> YearMonthDay {
    let today = Date()

    let year = Calendar.current.component(.year, from: today)
    let month = Calendar.current.component(.month, from: today)
    let day = Calendar.current.component(.day, from: today)

    print("年: \(year), 月: \(month), 日: \(day)")
    return YearMonthDay(year: year, month: month, day: day)
}
