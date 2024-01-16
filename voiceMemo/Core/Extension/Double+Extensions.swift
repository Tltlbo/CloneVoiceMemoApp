//
//  Double+Extensions.swift
//  voiceMemo
//

import Foundation

extension Double {
    //03:05초 표시를 위함
    var formattedTimeInterval : String {
        let totalSeconds = Int(self)
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
