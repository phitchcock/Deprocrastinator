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



        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        //let item: AnyObject = myList.removeAtIndex(indexPath.row)
        //myList.append(item)

        //tableView.moveRowAtIndexPath(indexPath, toIndexPath: NSIndexPath(forRow: myList.count - 1, inSection: 1))



        //let tappedItem = itemsArray[indexPath.row]
        //UITableViewCellAccessoryType.Checkmark


    }

    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {

        let val = self.myList.removeAtIndex(sourceIndexPath.row)
        self.myList.insert(val, atIndex: destinationIndexPath.row)



    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!

        switch editingStyle {
        case .Delete:
                self.myList.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }
}

