//
//  AddPirateViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Flatiron School on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddPirateViewController: UIViewController {
    
    @IBOutlet weak var newPirateTextField: UITextField!
    
    let store = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        let pirateDescription = NSEntityDescription.entityForName("Pirate", inManagedObjectContext: store.managedObjectContext)
        
        if let pirateDescription = pirateDescription {
            
            let newPirate = Pirate(entity: pirateDescription, insertIntoManagedObjectContext: store.managedObjectContext)
            newPirate.name = newPirateTextField.text
        }
        store.saveContext()
    
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
}
