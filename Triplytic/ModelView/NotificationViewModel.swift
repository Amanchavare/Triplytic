//
//  NotificationModel.swift
//  Triplytic experiment 
//
//  Created by Aman Niranjan Chavare on 18/12/24.
//

import Foundation
import Foundation

class NotificationsViewModel: ObservableObject {
    @Published var notifications: [Notification] = []

    func addNotification(title: String, date: Date) {
        let newNotification = Notification(title: title, date: date)
        
        // Optional: Prevent duplicate notifications
        if !notifications.contains(where: { $0.title == title && $0.date == date }) {
            notifications.append(newNotification)
        }
    }

    func deleteNotification(at offsets: IndexSet) {
        notifications.remove(atOffsets: offsets)
    }
}
