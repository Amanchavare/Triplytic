import SwiftUI

struct NotificationsView: View {
    @StateObject private var notificationsViewModel = NotificationsViewModel()
    @State private var showingAddNotification = false

    var body: some View {
        NavigationView {
            VStack {
                if notificationsViewModel.notifications.isEmpty {
                    Text("No notifications yet!")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(notificationsViewModel.notifications, id: \.id) { notification in
                            VStack(alignment: .leading) {
                                Text(notification.title)
                                    .font(.headline)
                                Text(notification.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete { indexSet in
                            notificationsViewModel.deleteNotification(at: indexSet)
                        }
                    }
                }
            }
            .navigationTitle("Notifications")
            .toolbar {
                Button(action: {
                    showingAddNotification = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                }
            }
            .sheet(isPresented: $showingAddNotification) {
                AddNotificationView(viewModel: notificationsViewModel)
            }
        }
    }
}
