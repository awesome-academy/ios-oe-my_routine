//
//  Constants.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/19/19.
//  Copyright © 2019 huy. All rights reserved.
//

class Constants {
    
    static let suggestIcon = ["⚽️", "🏃🏻‍♂️", "💪🏻", "📖", "🚴🏻‍♂️", "🏊🏻‍♂️"]
    static let suggestNameRoutine = ["Đá bóng", "Chạy bộ", "Tập Gym", "Đọc sách", "Đạp xe", "Bơi lội"]
    static let defaultComponents = ["Lặp lại", "Ngày bắt đầu", "Mục tiêu thực hiện", "Nhắc nhở", "Thời gian trong ngày"]
    static let iconCategory = [ #imageLiteral(resourceName: "repeat"), #imageLiteral(resourceName: "calendar"), #imageLiteral(resourceName: "target"), #imageLiteral(resourceName: "remind"), #imageLiteral(resourceName: "time")]
    static let defaultNewRoutine = ["Hàng ngày", "Hôm nay", "1 lần / ngày", "09:00", "Mọi lúc"]
    static let allWeek: [DayOfWeek] = [.Sunday, .Monday, .Tuesday, .Wednesday,
                                       .Thursday, .Friday, .Saturday]
    static let numberDayOnWeek = 7
    static let dateFormat = "YYYY/MM/dd"
    static let dateFullFormat = "YYYY/MM/dd ZZZZ"
    static let freeDayStatus = "Tận hưởng một ngày nghỉ nhé !"
}
