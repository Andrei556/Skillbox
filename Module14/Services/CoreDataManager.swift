
import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let fetchRequestWeather: NSFetchRequest<WeatherCD> = WeatherCD.fetchRequest()
    let fetchRequestTask: NSFetchRequest<Task> = Task.fetchRequest()
    
    init() {}
        
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Module14")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
 
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return CoreDataManager.instance.persistentContainer.viewContext
      }()

    func saveContext () {

        if context.hasChanges {
            do {
                try context.save()
            } catch {
 
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
       }
}
