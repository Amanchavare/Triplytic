import SwiftUI

struct NotesJournalView: View {
    @State private var notes: [JournalNote] = [
        JournalNote(title: "Day 1: Arrival", content: "Landed at my destination and explored the local market."),
        JournalNote(title: "Day 2: Sightseeing", content: "Visited historical landmarks and had amazing street food.")
    ]
    @State private var showAddNoteView = false

    var body: some View {
        NavigationView {
            VStack {
                if notes.isEmpty {
                    Text("No journal entries yet. Start writing!")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(notes) { note in
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                        }
                        .onDelete(perform: deleteNote)
                    }
                }
            }
            .navigationTitle("Notes & Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddNoteView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddNoteView) {
                AddNoteView(notes: $notes)
            }
        }
    }

    private func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}

struct JournalNote: Identifiable {
    let id = UUID()
    var title: String
    var content: String
}

struct NotesJournalView_Previews: PreviewProvider {
    static var previews: some View {
        NotesJournalView()
    }
}

import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var notes: [JournalNote]
    
    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationTitle("Add Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if !title.isEmpty && !content.isEmpty {
                            let newNote = JournalNote(title: title, content: content)
                            notes.append(newNote)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(notes: .constant([]))
    }
}

