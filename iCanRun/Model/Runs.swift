//
//  Runs.swift
//  iCanRun
//
//  Created by Eric Torigian on 4/17/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import Foundation

struct Runs {
    
    var name: String
    var date: String
    var time: String
    var distance: String
    var pace: String
    var mood: String
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "date": date,
            "time": time,
            "distance": distance,
            "pace": pace,
            "mood": mood,
        ]
    }
}
