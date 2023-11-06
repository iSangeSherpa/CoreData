//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Sange Sherpa on 03/11/2023.
//

import UIKit
import CoreData

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
//        createData()
        deleteData()
        retrieveData()
//        updateData()
    }
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
        
        for i in 1...5 {
            let user = NSManagedObject(entity: entity, insertInto: managedContext)
            user.setValue("user = \(i)", forKey: "username")
            user.setValue("user\(i)@gmail.com", forKey: "email")
            user.setValue("** \(i) **", forKey: "password")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let result = try managedContext.fetch(request)
            
            for data in result as! [NSManagedObject] {
                if let data = data.value(forKey: "username") {
                    print(data)
                }
            }
        }
        catch {
            print("Failed to retrieve data")
        }
    }
    
    func updateData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "User - 5")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            let updatedObject = result[0] as! NSManagedObject
            updatedObject.setValue("Mike", forKey: "username")
            updatedObject.setValue("mikeyy123@gmail.com", forKey: "email")
            updatedObject.setValue("it'smike123", forKey: "password")
            
            do {
                try managedContext.save()
            } catch let err as NSError{
                print(err)
            }
        } catch {
            print("Cannot retrieve data")
        }
    }
    
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Mike")
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            } catch {
                print("Unable to delete specified object")
            }

        } catch {
            print("Failedd")
        }
    }

}

