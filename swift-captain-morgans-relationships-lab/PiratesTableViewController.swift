//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Flatiron School on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class PiratesTableViewController: UITableViewController {
    let store = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchPirateData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        store.fetchPirateData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.pirates.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("pirateCell", forIndexPath: indexPath)
        
        let eachPirate = store.pirates[indexPath.row]
        cell.textLabel?.text = eachPirate.name
        
        return cell
    }
    
    // Use a segue to pass the selected pirate to the ships tableVC...
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? ShipsTableViewController {
            let selectedRow = tableView.indexPathForSelectedRow
            let selectedPirate = store.pirates[selectedRow!.row]
            destinationVC.pirate = selectedPirate
        }
    }
    
}