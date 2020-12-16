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

        //set up for table view
        EventTableView.delegate = self
        EventTableView.dataSource = self
        
        // gets info from dataModel
        fetchEvent()
        
    }
    
    // hides the navigation for this page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
     
    }
    
    // when add event is clicked it goes to add page and shows the navigation
    @IBAction func addEventClicked(_ sender: Any) {
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        //counts the rows
        return self.events?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // set my cell connection
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! GiftEventTableViewCell
        
        // get my event array
        let event = self.events![indexPath.row]
        
        // set labels in prodotype cell
        eventCell.EventLabel.text = event.event
        eventCell.nameLabel.text = event.name
        
        //converts date into a string
        let dateForm = DateFormatter()
        dateForm.dateFormat = "MMM d, yyyy"
        
        // set date to label as string
        eventCell.dateLabel.text = dateForm.string(for: event.date)
        
        return eventCell
    }

    // on clicking a cell goes to new page with the info of that event and
    // will then allow to add gift ideas to that event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetails:GiftDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "GiftDetailsViewController") as! GiftDetailsViewController
       
        // grab event infor at index location
        let event = self.events![indexPath.row]
        
        // set details controllers varaibles equal to event info
        eventDetails.eventName = event.event!
        eventDetails.nameName = event.name!
        eventDetails.location = indexPath.row
        
        
        //converts date into a string
        let dateForm = DateFormatter()
        dateForm.dateFormat = "MMM d, yyyy"
        
        eventDetails.date = dateForm.string(for: event.date)!
        
        self.navigationController?.pushViewController(eventDetails, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // removes an item from list by swiping
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // action for removing item with remove label
        let action = UIContextualAction(style: .destructive, title: "Remove") { (action, view, handler) in
            
            // grabs the event that was swiped on
            let removeEvent = self.events![indexPath.row]
            
            //deletes the event
            self.context.delete(removeEvent)
            
            do {
                try self.context.save()
            }
            catch {
                print("Unable to remove Event!")
            }
            
            self.fetchEvent()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }

}
