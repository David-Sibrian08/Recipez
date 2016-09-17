//
//  ViewController.swift
//  Recipez
//
//  Created by Sibrian on 9/16/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipes = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }
    
    func fetchAndSetResults() {
        
        //1. grab the app delegate
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context = app.managedObjectContext  //our scratchpad
        let fetchRequest = NSFetchRequest(entityName: "Recipe")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.recipes = results as! [Recipe]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as? RecipeCell {
            
            let recipe = recipes[indexPath.row]
            cell.configureCell(recipe)
            return cell
        }
        return RecipeCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}


/*
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */


