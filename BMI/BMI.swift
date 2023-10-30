//
//  BMI.swift
//  BMI
//
//  Created by apple on 10/20/23.
//

import Foundation

struct BMI {
    var name: String?
    var gender: Gender
    var height: Int
    var weight: Int
    var age: Int
}

enum Gender {
    case Female
    case Male
}
