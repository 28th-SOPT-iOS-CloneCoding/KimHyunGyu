//
//  PersistenceManager.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/30.
//

import Foundation
import CoreData

class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // fetch
    func fetch<T :NSManagedObject>(reqeust: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(reqeust)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    //insert data
     @discardableResult
    func insertStory(story: Story) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "StoryModel", in: self.context)
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(story.title, forKey: "title")
            managedObject.setValue(story.detail, forKey: "detail")
            managedObject.setValue(story.date, forKey: "date")
            
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    // delete
    @discardableResult
    func delete(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    // delete all
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    // count
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int? {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            return nil
        }
    }
}

//count
//let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
//print(PersistenceManager.shared.count(request: request))

//delete all
//let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
//PersistenceManager.shared.deleteAll(request: request)
//let arr = PersistenceManager.shared.fetch(request: request)
//if arr.isEmpty {
//    print("clean") // Print "clean"
//
//}

//delete
//let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
//let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
//PersistenceManager.shared.delete(object: fetchResult.last!)

//insert
//let storyOne = Story(title: "story1", detail: "detail1", date: "date1")
//PersistenceManager.shared.insertStory(story: storyOne)

//fetch
//let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
//let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
