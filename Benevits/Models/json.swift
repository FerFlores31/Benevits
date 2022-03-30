//
//  json.swift
//  Benevits
//
//  Created by Fer on 26/03/22.
//

import Foundation

typealias ChartObject = [BenevitModel]

struct BenevitModel : Codable {
    var id : Int?
    var display_index : Int?
    var display_text : String?
    var icon : String?
    var path : String?
    var max_level : Int?
    var avatar : String?
    var name : String?
    var benevit_count : Int?
    var mobile_cover_url : JSONNull?
    var desktop_cover_url : JSONNull?
    var member_level : Int?
    var primary_color : String?
    var max_level_phase_2 : Int?
    var max_level_phase_3 : Int?
    var max_level_phase_4 : Int?
    var max_level_phase_5 : Int?
}


