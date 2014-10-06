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
    }

    func saveData() {

        //Reference app del
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        //Reference context
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!

        let entityList = NSEntityDescription.entityForName("TodoModel", inManagedObjectContext: contxt)

        var newItem = TodoModel(entity: entityList!, insertIntoManagedObjectContext: contxt)

        newItem.item = itemTextField.text

        //Save Context
        contxt.save(nil)

    }

    func getData() {

        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        //Get data
        //Fetch request
        let fetchRequest = NSFetchRequest(entityName: "TodoModel")

        //Save data in datasource
        myList = contxt.executeFetchRequest(fetchRequest, error: nil)!
        
        //Reload Data
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

    /*
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        //let tappedItem = itemsArray[indexPath.row]
        UITableViewCellAccessoryType.Checkmark


    }
*/

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {


        //Reference app del
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        //Reference context
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


}

