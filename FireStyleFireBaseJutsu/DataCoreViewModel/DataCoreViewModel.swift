//
//  CoreDataViewModel.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/27/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import CoreData
import Foundation

class DataCoreViewModel { // write update & insert in a bit 
    
    var connectionsCollection = [Connection]() // private? or ...
    
    func getNumbOfConnections() -> Int {
        return connectionsCollection.count
    }
    
    // to be updated when have more complex structure
    func createOneNewConnection(cover: String, dial: String) {
        let newConnection = Connection(context: PersistenceRelevant.ultimateContext)
        
        newConnection.dial = dial
        newConnection.cover = cover
        
        connectionsCollection.append(newConnection)
        
        PersistenceRelevant.ultimateContext.insert(newConnection)
        // insert necessary or...?
            
        PersistenceRelevant.savingContext()
    }
    
    func getCoverAndDial(indexPathDotRow: Int) -> [String] {
        guard let dial = connectionsCollection[indexPathDotRow].dial else { return ["Nothingness"]}
        guard let cover = connectionsCollection[indexPathDotRow].cover else {
            return ["Nothing"] }
        
        return [cover, dial]
    }
    
    func deleteConnection(indexPathDotRow: Int) { // method tailored to tableV
        
        let contextForDeletion = PersistenceRelevant.ultimateContext
        
        let connectionToBeDeleted = connectionsCollection[indexPathDotRow]
        
        contextForDeletion.delete(connectionToBeDeleted)
        
        connectionsCollection.remove(at: indexPathDotRow)
        
//        do {
//            try contextForDeletion.save()
//        } catch {
//            print("erro tryna delete")
//        }
        
        // MARK: -
                // experiment with either
        do {
            try PersistenceRelevant.ultimateContext.save()
        } catch {
            print("persis erro delete")
        }
    }
    
    func fetchConnection() {
        
        let fetchRequ: NSFetchRequest<Connection> = Connection.fetchRequest()
        
        do {
            let connectionsToBeFetched = try PersistenceRelevant.ultimateContext.fetch(fetchRequ)
            self.connectionsCollection = connectionsToBeFetched
        } catch {
            print("erro tryna fetch")
        }
    }
    
}

// try insert later
