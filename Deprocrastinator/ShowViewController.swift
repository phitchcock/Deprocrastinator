//
//  ShowViewController.swift
//  Deprocrastinator
//
//  Created by Peter Hitchcock on 10/6/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit
import CoreData

class ShowViewController: UIViewController {

    //Vars
    var item:String!
    var existingItem:NSManagedObject!

    //IBOutlets
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var updatedLabel: UILabel!

    //IBActions
    @IBAction func updateButtonPressed(sender: AnyObject) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        if (existingItem != nil) {
            existingItem.setValue(itemTextField.text as String, forKey: "item")
            updatedLabel.text = "Your todo has been updated to \(itemTextField.text), would you like to update again?"

            contxt.save(nil)
            itemTextField.text = ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
        updatedLabel.text = "Would you like to update your item?"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
