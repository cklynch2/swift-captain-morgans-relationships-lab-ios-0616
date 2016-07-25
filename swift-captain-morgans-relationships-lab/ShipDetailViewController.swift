//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Flatiron School on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class ShipDetailViewController: UIViewController {
    var ship : Ship?
    
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var pirateNameLabel: UILabel!
    @IBOutlet weak var propulsionTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.removeConstraints(view.constraints)
        setLabelConstraints()
        setTextForLabels()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setLabelConstraints() {
        shipNameLabel.translatesAutoresizingMaskIntoConstraints = false
        shipNameLabel.removeConstraints(shipNameLabel.constraints)
        shipNameLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        shipNameLabel.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 80.0).active = true
        shipNameLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        
        pirateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pirateNameLabel.removeConstraints(pirateNameLabel.constraints)
        pirateNameLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        pirateNameLabel.topAnchor.constraintEqualToAnchor(shipNameLabel.bottomAnchor, constant: 30.0).active = true
        pirateNameLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        
        propulsionTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        propulsionTypeLabel.removeConstraints(propulsionTypeLabel.constraints)
        propulsionTypeLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        propulsionTypeLabel.topAnchor.constraintEqualToAnchor(pirateNameLabel.bottomAnchor, constant: 30.0).active = true
        propulsionTypeLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
    }
    
    func setTextForLabels() {
        if let shipName = ship?.name {
            shipNameLabel.text = ("Name: \(shipName)")
        }
        
        let pirate = ship?.pirate as! Pirate
        if let pirateName = pirate.name {
            pirateNameLabel.text = ("Pirate: \(pirateName)")
        }
        
        let engine = ship?.engine as! Engine
        if let engineType = engine.propulsion {
            propulsionTypeLabel.text = ("Engine: \(engineType)")
        }
    }

}
