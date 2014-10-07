//
//  ShowViewController.swift
//  Deprocrastinator
//
//  Created by Peter Hitchcock on 10/6/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    //Vars
    var item:String!

    //IBOutlets
    @IBOutlet weak var itemTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
