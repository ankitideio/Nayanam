//
//  TimeAgo.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct TimeAgo: ViewModifier {
    let timestamp: TimeInterval
    
    func body(content: Content) -> some View {
        Text(timeAgoDisplay(timestamp: timestamp))
            .foregroundColor(.gray) // You can adjust the color as needed
            .font(.caption) // You can adjust the font size as needed
    }
    
    private func timeAgoDisplay(timestamp: TimeInterval) -> String {
        let currentDate = Date()
        let secondsAgo = Int(currentDate.timeIntervalSince1970 - (timestamp / 1_000_000_000))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let month = 30 * day
        let year = 12 * month
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            let minutes = secondsAgo / minute
            return "\(minutes) minutes ago"
        } else if secondsAgo < day {
            let hours = secondsAgo / hour
            return "\(hours) hours ago"
        } else if secondsAgo < month {
            let days = secondsAgo / day
            return "\(days) days ago"
        } else if secondsAgo < year {
            let months = secondsAgo / month
            return "\(months) months ago"
        } else {
            let years = secondsAgo / year
            return "\(years) years ago"
        }
    }
}

extension View {
    func timeAgo(timestamp: TimeInterval) -> some View {
        self.modifier(TimeAgo(timestamp: timestamp))
    }
    func commentDate(time: Int) -> String {
            let date = Date(timeIntervalSince1970: TimeInterval(time) / 1_000_000_000)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }
}
