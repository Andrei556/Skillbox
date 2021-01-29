
import Foundation
import CoreData

extension WeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCD> {
        return NSFetchRequest<WeatherCD>(entityName: "WeatherCD")
    }

    @NSManaged public var cloud: String?
    @NSManaged public var condition: String?
    @NSManaged public var humidity: Double
    @NSManaged public var temp: Double
    @NSManaged public var wind: String?
    @NSManaged public var windSpeed: Double

}

extension WeatherCD : Identifiable {
    
}
