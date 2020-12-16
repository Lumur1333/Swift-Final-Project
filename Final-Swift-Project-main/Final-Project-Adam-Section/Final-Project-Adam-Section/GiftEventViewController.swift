//
//  GiftEventViewController.swift
//  Final-Project-Adam-Section
//
//  Created by Adam Mcnown on 2020-12-12.
//  Copyright © 2020 Adam McNown. All rights reserved.
//

import UIKit

class GiftEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    // outlet connections
    @IBOutlet weak var EventTableView: UITableView!
    
    // reference to corse data context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // local varables
    var events:[Event]?

    override func viewDidLoad() {
        super.viewDidLoad()

        EventTableView.delegate = self
        EventTableView.dataSource = self
        
        fetchEvent()
        
    }
    
    // get the data from DataModel core data for displaying
    func fetchEvent() {
        do {
            self.events = try context.fetch(Event.fetchRequest())
            
            DispatchQueue.main.async {
                self.EventTableView.reloadData()
            }
            
        }
        catch {
            print("Was unable to grab Event data")
        }
    }
    
    // table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // set my cell connection
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! GiftEventTableViewCell
        
        // get my event array
        let event = self.events![indexPath.row]
        
        eventCell.EventLabel.text = event.event
        eventCell.nameLabel.text = event.name
        
        //converts date into a string
        let dateForm = DateFormatter()
        dateForm.dateFormat = "MMM d, yyyy"
        
        eventCell.dateLabel.text = dateForm.string(for: event.date)
        
        return eventCell
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
