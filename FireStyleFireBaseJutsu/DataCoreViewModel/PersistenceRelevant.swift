//
//  GenericCoreDataManager.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/28/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Foundation
import CoreData

class PersistenceRelevant { // CoreDataCore
    
    static let shared = PersistenceRelevant()
    private init() { }
    
    static var ultimateContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        
        
        let virtualContactsContainer = NSPersistentContainer(name: "VirtualContacts")
        
        virtualContactsContainer.loadPersistentStores { (storeDescription, erro) in
            print("store description is \(storeDescription)")
            print("Erro is \(erro.debugDescription)")
        }

        return virtualContactsContainer
    }()
    
    static func savingContext() {
        
        let contextToBeSaved = persistentContainer.viewContext
        
        if contextToBeSaved.hasChanges {
            do {
                try contextToBeSaved.save()
                print("just to make sure that it saved")
            } catch {
                print(error)
            }
        }
    }
}
