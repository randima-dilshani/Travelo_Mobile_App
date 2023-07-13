//
//  Action.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import Foundation

struct Action : Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let handler: ()-> Void
}

