//
//  YearMonthDayExtension.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/07.
//

import SwiftUI

// YearMonthDayからDateに変換する拡張機能
extension YearMonthDay {
    func toDate() -> Date? {
        var components = DateComponents()
        components.year = year != 0 ? year : nil
        components.month = month != 0 ? month : nil
        components.day = day != 0 ? day : nil
        return Calendar.current.date(from: components)
    }
}
