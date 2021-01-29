
import Foundation
import CoreData

@objc(WeatherCD)
public class WeatherCD: NSManagedObject {
    
    convenience init () {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "WeatherCD"), insertInto: CoreDataManager.instance.context)
    }
}
