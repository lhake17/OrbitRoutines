import SwiftUI
import CoreData

struct ContentView: View {
    //sets up the environment context
    @Environment(\.managedObjectContext) private var viewContext
    
    // fetch all routines from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Routine.timestamp, ascending: true)],
        animation: .bouncy)
    private var routines: FetchedResults<Routine>
    
    var body: some View {
        NavigationView {
            VStack {
                if routines.isEmpty {
                    Text("Keine Routinen verfügbar")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(routines) { routine in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(routine.name ?? "Keine Beschreibung")
                                        .font(.headline)
                                    
                                    Text(routine.timestamp ?? Date(), style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteRoutine)
                    }
                }
            }
            .navigationTitle("Routinen")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addRoutine) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }
    
    // MARK: - Funktionen
    
    private func addRoutine() {
        let newRoutine = Routine(context: viewContext)
        newRoutine.timestamp = Date()
        newRoutine.name = "TEST"
        
        do {
            try viewContext.save()
        } catch {
            print("Fehler beim Speichern: \(error.localizedDescription)")
        }
    }
    
    private func deleteRoutine(at offsets: IndexSet) {
        for index in offsets {
            let routineToDelete = routines[index]
            viewContext.delete(routineToDelete)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Fehler beim Löschen: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
