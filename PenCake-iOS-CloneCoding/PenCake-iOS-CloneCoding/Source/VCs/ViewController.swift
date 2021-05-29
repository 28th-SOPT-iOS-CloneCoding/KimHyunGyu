//
//  ViewController.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/27.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: - Properties
//    var container: NSPersistentContainer!
    
    
    
    struct Story {
        var title: String
        var detail: String
        var date: String
    }
    
    // MARK: - @IBOutlet Properteis
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard container != nil else {
//            fatalError("This view needs a persistent container.")
//        }
        
        // The persistent container is available.
//        setCoreData()
        fetchStory()
    }
}

extension ViewController {
    private func setCoreData() {
        
        let storyOne = Story(title: "일기2", detail: "디테일2", date: "20210528")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "StoryModel", in: context)
        
        if let entity = entity {
            let story = NSManagedObject(entity: entity, insertInto: context)
            story.setValue(storyOne.title, forKey: "title")
            story.setValue(storyOne.detail, forKey: "detail")
            story.setValue(storyOne.date, forKey: "date")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchStory() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let story = try context.fetch(StoryModel.fetchRequest()) as! [StoryModel]
            story.forEach {
                print($0.title!)
                print($0.detail!)
                print($0.date!)
            }
        } catch {
            print(error.localizedDescription)
            
        }

    }
}
