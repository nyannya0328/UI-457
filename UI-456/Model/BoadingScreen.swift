//
//  BoadingScreen.swift
//  UI-313 (iOS)
//
//  Created by nyannyan0328 on 2021/09/21.
//

import SwiftUI

struct BoadingScreen: Identifiable {
    var id = UUID().uuidString
    var image : String
    var title : String
    var decription : String
    
}

let title = "Easy Payments with \nWallestroy"

let description = "Small business can recive device \npayment super fast and super easy"

let tilte2 = "abv"
let descr = "aiueo"
//since image name and BG color name are same

var bodingscrrens : [BoadingScreen] = [


BoadingScreen(image: "screen1", title: title, decription: description),
BoadingScreen(image: "screen2", title: tilte2, decription: descr),
BoadingScreen(image: "screen3", title: title, decription: description),
BoadingScreen(image: "screen4", title: title, decription: description),

]



