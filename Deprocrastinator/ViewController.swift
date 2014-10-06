//
//  ViewController.swift
//  Deprocrastinator
//
//  Created by Peter Hitchcock on 10/6/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    //Vars
    var myList: Array<AnyObject> = []

    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemTextField: UITextField!

    //IBActions
    @IBAction func onAddButtonPressed(sender: AnyObject) {
        saveData()
        getData()
        itemTextField.text = ""
        itemTextField.resignFirstResponder()
    }

    func saveData() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        let entityList = NSEntityDescription.entityForName("TodoModel", inManagedObjectContext: contxt)
        var newItem = TodoModel(entity: entityList!, insertIntoManagedObjectContext: contxt)
        newItem.item = itemTextField.text
        contxt.save(nil)
    }

    func getData() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "TodoModel")
        myList = contxt.executeFetchRequest(fetchRequest, error: nil)!
        tableView.reloadData()
    }


    override func viewDidAppear(animated: Bool) {
        getData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TodoCell = tableView.dequeueReusableCellWithIdentifier("dCell", forIndexPath: indexPath) as TodoCell
        var data: NSManagedObject = myList[indexPath.row] as NSManagedObject
        var info = data.valueForKey("item") as String
        cell.todoCellLabel.text = data.valueForKey("item") as? String
        return cell
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)

        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
        }))

        self.presentViewController(alert, animated: true, completion: nil)



    }
    /*
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
*/

    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {

        //let val: AnyObject = myList.removeAtIndex(sourceIndexPath.row)
       // myList.insert(val, atIndex: destinationIndexPath.row)
        //let item = myList.removeAtIndex(indexPath.row)

    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        if editingStyle == UITableViewCellEditingStyle.Delete {
            contxt.deleteObject((myList[indexPath.row] as NSManagedObject))
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            var error: NSError? = nil
            if !contxt.save(&error) {
                abort()
            }
        }
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}

