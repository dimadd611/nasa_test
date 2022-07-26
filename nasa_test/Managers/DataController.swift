//
//  DataController.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 24.07.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "Main")

    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores {
            (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }

    func createNote() -> Rover {
        let rover = Rover(context: viewContext)
        rover.id = 0
        rover.earthDate = ""
        rover.image = ""
        rover.roverType = ""
        save()
        return rover
    }

    // Saving notes to database
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error occured while saving data: \(error.localizedDescription)")
            }
        }
    }

    func fetchRovers() -> [Rover] {
        let request: NSFetchRequest<Rover> = Rover.fetchRequest()
      let sortDescriptor = NSSortDescriptor(keyPath: \Rover.id, ascending: false)
        request.sortDescriptors = [sortDescriptor]
      

        // filtering notes
//        if let filter = filter {
//            let pr1 = NSPredicate(format: "title contains[cd] %@", filter)
//            let pr2 = NSPredicate(format: "text contains[cd] %@", filter)
//            let predicate = NSCompoundPredicate(type: .or, subpredicates: [pr1, pr2])
//            request.predicate = predicate
//        }
        return (try? viewContext.fetch(request)) ?? []
    }

    func deleteNote(_ rover: Rover) {
        viewContext.delete(rover)
        save()
    }
}
