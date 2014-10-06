//
//  ViewController.swift
//  Deprocrastinator
//
//  Created by Peter Hitchcock on 10/6/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    //Vars
    var itemsArray:[String] = []

    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemTextField: UITextField!

    //IBActions
    @IBAction func onAddButtonPressed(sender: AnyObject) {

        var item = itemTextField.text
        itemsArray.append(item)
        tableView.reloadData()
        itemTextField.endEditing(true)
        itemTextField.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemsArray.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:TodoCell = tableView.dequeueReusableCellWithIdentifier("dCell", forIndexPath: indexPath) as TodoCell

        cell.todoCellLabel.text = itemsArray[indexPath.row]

        return cell
    }

}

