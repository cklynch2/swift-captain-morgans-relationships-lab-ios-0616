//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Flatiron School on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class ShipsTableViewController: UITableViewController {
    var pirate: Pirate!
    var ships = [Ship]()
    let store = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShipsToLocalArray()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        addShipsToLocalArray()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func addShipsToLocalArray() {
        for ship in pirate.ships! {
            ships.append(ship as! Ship)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let ships = pirate.ships {
            return ships.count
        }
        print("This pirate has no ships.")
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("shipCell", forIndexPath: indexPath)
        
        let eachShip = ships[indexPath.row]
        cell.textLabel?.text = eachShip.name
        
        return cell
    }
    
    // Use a segue to pass the selected ship to the ship detail VC...
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "shipDetailSegue" {
        
            if let destinationVC = segue.destinationViewController as? ShipDetailViewController {
                let selectedRow = tableView.indexPathForSelectedRow
                let selectedShip = ships[selectedRow!.row]
                destinationVC.ship = selectedShip as Ship?
            }
        
        } else if segue.identifier == "addShipSegue" {
            
            if let destinationVC = segue.destinationViewController as? AddShipViewController {
                destinationVC.pirate = pirate as Pirate?
            }
        }
    }
}
