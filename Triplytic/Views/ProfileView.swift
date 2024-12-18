import SwiftUI

struct ProfileView: View {
    @State private var username: String = "John Doe"
    @State private var email: String = "john.doe@example.com"
    @State private var phoneNumber: String = "+1 234 567 890"
    @State private var isDarkMode: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                    TextField("Phone Number", text: $phoneNumber)
                }

                Section(header: Text("Preferences")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                }

                Section {
                    Button(action: {
                        // Log out action or any other settings related actions
                        print("Logging out...")
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.circle.fill")
                            Text("Log Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
