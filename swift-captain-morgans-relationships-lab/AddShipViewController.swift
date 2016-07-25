//
//  AddShipViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Flatiron School on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddShipViewController: UIViewController, UIPickerViewDelegate,  UIPickerViewDataSource {
    
    @IBOutlet weak var newShipTextField: UITextField!
    @IBOutlet weak var propulsionPicker: UIPickerView!
    
    var propulsionTypes = ["Sail", "Gas", "Electric"]
    var pirate : Pirate?
    let store = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Was the pirate passed from previous view controller? \(pirate)")
        propulsionPicker.delegate = self
        propulsionPicker.dataSource = self
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return propulsionTypes.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return propulsionTypes[row]
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        let selectedRow = propulsionPicker.selectedRowInComponent(0)
        let selectedPropulsion = propulsionTypes[selectedRow]
        
        let shipDescription = NSEntityDescription.entityForName("Ship", inManagedObjectContext: store.managedObjectContext)
        
        let engineDescription = NSEntityDescription.entityForName("Engine", inManagedObjectContext: store.managedObjectContext)
        
        if let shipDescription = shipDescription, engineDescription = engineDescription {
            
            let newShip = Ship(entity: shipDescription, insertIntoManagedObjectContext: store.managedObjectContext)
            newShip.name = newShipTextField.text
            
            let newEngine = Engine(entity: engineDescription, insertIntoManagedObjectContext: store.managedObjectContext)
            newEngine.propulsion = selectedPropulsion
            
            newShip.engine = newEngine
            newShip.pirate = pirate
        }
        store.saveContext()
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

}
