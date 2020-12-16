//
//  GiftDetailsViewController.swift
//  Final-Project-Adam-Section
//
//  Created by Parth Bhavesh Kumar Bhatt on 2020-12-13.
//  Copyright © 2020 Adam McNown. All rights reserved.
//

import UIKit
import os.log
import CoreData

class GiftDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
//outlet connections
    @IBOutlet weak var eventLbel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    @IBOutlet weak var ideaTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var DetailsTableView: UITableView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //local variables
    var eventName:String!
    var nameName:String!
    var date:String!
    var location:Int!
    
    
    //reference to core data context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //data for the table
    var items:[GiftDetails]?
    var events:[Event]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventLbel.text = eventName
        nameLabel.text = nameName
        dateLabel.text = date
        

        // Do any additional setup after loading the view.
        
        
       // setup for table view
        DetailsTableView.dataSource = self
        DetailsTableView.delegate = self
        
        //gets info from DataModel
        fetchItems()
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)

        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }
    
    //get data from DataModel core data
    func fetchItems() {
        
        do{
            let request: NSFetchRequest<GiftDetails> = GiftDetails.fetchRequest()
            
            //set the filtering and sorting on th request
            
            self.items = try context.fetch(request)
        
            DispatchQueue.main.async{
                self.DetailsTableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    //table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //set my cell connection
        let detailsCell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! GiftDetailsTableViewCell
        
        self.items = try! context.fetch(GiftDetails.fetchRequest())
        
        //get my item's array
        let item = self.items![indexPath.row]
        
        //set labels in detailsCell prototype cell
        detailsCell.ideaLabel.text = item.idea
        detailsCell.locationLabel.text = item.location
        
        //format to decimal
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        //set priceLabel as string after formating
        detailsCell.priceLabel.text = formatter.string(for: item.price)
        
        return detailsCell
    }
    
    //on clicking save button, saves the tems to the table view and is displayed
    @IBAction func saveBtnClicked(_ sender: Any) {
    
        //variables
        let giftIdea = GiftDetails(context: self.context)
        //var event = Event(context: self.context)
        
        //Create an event object for each field
        giftIdea.idea = "Gift Idea: " + ideaTextField.text!
        giftIdea.location = "Location: " + locationTextField.text!
        giftIdea.price = Double(priceTextField.text!)!
        
        let event = self.events?[location]
        
        event?.addToGifts(giftIdea)
        
        //Save the data for the fields
        try! self.context.save()
        
        ideaTextField.text! = ""
        locationTextField.text! = ""
        priceTextField.text! = ""
        
        fetchItems()
    }
    
    // removes an item from list by swiping
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //action for removing item with remove label
        let action = UIContextualAction(style: .destructive, title: "Remove") { (action, view, handler) in
            
            //grabs the item that was swiped on
            let removeItem = self.items![indexPath.row]
            
            //delets the item
            self.context.delete(removeItem)
            
            do {
                try self.context.save()
            }
            catch {
                print("Unable to remove Item!")
            }
            
            self.fetchItems()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


