//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Flatiron School on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    static let sharedDataStore = DataStore()
    
    var pirates: [Pirate] = []
    var ships: [Ship] = []
    var engines: [Engine] = []
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // MARK : - Fetch request functions
    
    // Now that the data model includes multiple entities, you can generalize the fetch function to take the entity name as a parameter. This allows you to call the fetch function from either Recipient or Messages view controller, depending on which data you need to get.
    func fetchDataByEntity(entityName: String, key: String?) -> [AnyObject] {
        var fetchArray = [AnyObject]()
        var error: NSError? = nil
        let request = NSFetchRequest(entityName: entityName)
        
        if let sortKey = key {
            let sortByKey = NSSortDescriptor(key: sortKey, ascending: true)
            request.sortDescriptors = [sortByKey]
        }
        
        do {
            // You do not need to cast in this case, because you are already working with the most general AnyObject type.
            fetchArray = try managedObjectContext.executeFetchRequest(request)
        } catch let nserror as NSError {
            error = nserror
            print("Fetch request caused an error: \(error)")
        }
        return fetchArray
    }
    
    // Or, you can have different fetch functions for each entity:
    func fetchPirateData () {
        var error: NSError? = nil
        
        let piratesRequest = NSFetchRequest(entityName: "Pirate")
        
        let pirateNameSorter = NSSortDescriptor(key: "name", ascending: true)
        piratesRequest.sortDescriptors = [pirateNameSorter]
        
        do {
            pirates = try managedObjectContext.executeFetchRequest(piratesRequest) as! [Pirate]
        } catch let nserror as NSError {
            error = nserror
            pirates = []
            print("Pirate fetch request caused an error: \(error)")
        }
        
        if pirates.count == 0 {
            generateTestData()
        }
    }
    
    func fetchShipData () {
        var error: NSError? = nil
        
        let shipsRequest = NSFetchRequest(entityName: "Ship")
        
        let shipNameSorter = NSSortDescriptor(key: "name", ascending: true)
        shipsRequest.sortDescriptors = [shipNameSorter]
        
        do {
            ships = try managedObjectContext.executeFetchRequest(shipsRequest) as! [Ship]
        } catch let nserror as NSError{
            error = nserror
            ships = []
            print("Ship fetch request caused an error: \(error)")
        }
        
        if ships.count == 0 {
            generateTestData()
        }
    }
    
    // MARK: - Generate test data
    
    func generateTestData() {
        
        let pirateOne: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        pirateOne.name = "One-Eyed Claire"
        
        let pirateTwo: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        pirateTwo.name = "One-Legged Cenker"
        
        let pirateThree: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        pirateThree.name = "Parrot-Keeper Ken"
        
        let shipOne = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipOne.name = "African Queen"
        shipOne.pirate = pirateOne
        
        let shipTwo = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipTwo.name = "Adventure Galley"
        shipTwo.pirate = pirateOne
        
        let shipThree = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipThree.name = "New York Revenge"
        shipThree.pirate = pirateTwo
        
        let shipFour = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipFour.name = "Night Rambler"
        shipFour.pirate = pirateTwo
        
        let shipFive = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipFive.name = "Loyal Fortune"
        shipFive.pirate = pirateThree
        
        let engineOne = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        engineOne.propulsion = "Sail"
        engineOne.ship = shipOne
        
        let engineTwo = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        engineTwo.propulsion = "Gas"
        engineTwo.ship = shipTwo
        
        let engineThree = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        engineThree.propulsion = "Electric"
        engineThree.ship = shipThree
        
        let engineFour = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        engineFour.propulsion = "Sail"
        engineFour.ship = shipFour
        
        let engineFive = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        engineFive.propulsion = "Gas"
        engineFive.ship = shipFive

        saveContext()
        fetchPirateData()
        fetchShipData()
        fetchDataByEntity("Engine", key: "propulsion")
    }
    
    // MARK: - Core Data stack
    // Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("swift_captain_morgans_relationships_lab", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("swift_captain_morgans_relationships_lab.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    //MARK: Application's Documents directory
    // Returns the URL to the application's Documents directory.
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.SlapChat" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
}
