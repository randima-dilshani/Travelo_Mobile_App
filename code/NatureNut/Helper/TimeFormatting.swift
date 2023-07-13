//
//  TimeFormatting.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import Foundation

func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.mm.dd"
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate

}

