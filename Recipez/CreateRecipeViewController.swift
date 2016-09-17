//
//  CreateRecipeViewController.swift
//  Recipez
//
//  Created by Sibrian on 9/17/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        recipeImage.layer.cornerRadius = 4.0
        recipeImage.clipsToBounds = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImage.image = image
    }
    
    @IBAction func addImageButtonPressed(sender: UIButton) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        sender.setTitle("", forState: .Normal)
    }
    
    @IBAction func createRecipeButtonPressed(sender: UIButton) {
        if let title = recipeName.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
            let recipe = Recipe(entity: entity, insertIntoManagedObjectContext: context)
            
            recipe.title = recipeName.text
            recipe.ingredients = recipeIngredients.text
            
            if let steps = recipeSteps.text {
                recipe.steps = steps
            }
            
            recipe.setRecipeImage(recipeImage.image!)
            
            context.insertObject(recipe)
            
            do {
                try context.save()
            } catch {
                print("Could not save recipe")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
            
        } else {
            postMissingComponentsAlert()
        }
    }
    
    func postMissingComponentsAlert() {
        let alertController = UIAlertController(title: "Incomplete Recipe", message: "Make sure you have a title for your recipe", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Understood. ", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
