//
//  StyleConfig.swift
//  isMercuryInRetrograde
//
//  Created by Anna on 4/19/23.
//

import SwiftUI

let defaultStyleConfig = StyleConfig(backgroundColor: .gray, image: "planet", primaryColor: .gray)

struct StyleConfig{
    let backgroundColor: Color
    let image: String
    let primaryColor: Color
   
    static func determineConfig(from answer: String)-> StyleConfig{
        switch answer {
        case "Yes":
            return StyleConfig(backgroundColor: .black, image: "planet", primaryColor: .white)
        case "No":
            return defaultStyleConfig
        default:
            return defaultStyleConfig
        }
    
    }
}

