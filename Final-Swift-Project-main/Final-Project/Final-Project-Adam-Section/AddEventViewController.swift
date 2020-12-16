//
//  AddEventViewController.swift
//  Final-Project-Adam-Section
//
//  Created by Lucas Murdock on 2020-12-12.
//  Copyright © 2020 Adam McNown. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    //Local Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Outlet Connections
    @IBOutlet weak var EventNameText: UITextField!
    @IBOutlet weak var DateSelector: UIDatePicker!
    @IBOutlet weak var PersonName: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)

        // Do any additional setup after loading the view.
    }
    
    // forces back button navigation to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
     
    }

    
    @IBAction func AddEventClick(_ sender: Any) {
        //If statement for error handling
        if (EventNameText.text!.isEmpty) {
            alertEventName()
        } else if (PersonName.text!.isEmpty) {
            alertPersonName()
        } else {
            //variables
            let newEvent = Event(context: self.context)
            //Create an event object for each field
            newEvent.event = EventNameText.text!
            newEvent.name = PersonName.text!
            newEvent.date = DateSelector.date
            //Save the data for the fields
            try! self.context.save()
        }
    }

    //Error handler for Event Name
    func alertEventName() {
        let alertEventName = UIAlertController(title: "Alert!", message: "You must fill out an Event Name!", preferredStyle: .alert)
        let okActionEventName = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alertEventName.addAction(okActionEventName)
            present(alertEventName, animated: true, completion: nil)
    }
    //Error handler for Person Name
    func alertPersonName() {
        let alertPersonName = UIAlertController(title: "Alert!", message: "You must fill out a person's name!", preferredStyle: .alert)
        let okActionPersonName = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alertPersonName.addAction(okActionPersonName)
            present(alertPersonName, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
