
import UIKit

class WeatherViewController: UIViewController{
    
    var coreDataTask: [WeatherCD] = []
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var firstStack: UIStackView!
    @IBOutlet weak var secondStack: UIStackView!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var labelSeparate: UILabel!
    @IBOutlet weak var speedWind: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delay = 1 
        self.activity.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let load = WeatherService()
            load.fetchData(completion: { weather in
                if let count = try? weather.get() {
                    self.save(newWeather: count)
                    self.showUI()
                    self.setupView(weather: count)
            }
        })
    }
}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDataCD()
        if coreDataTask.count > 0 {
            city.text = "Москва"
            speedWind.text = coreDataTask[0].wind
            tempLabel.text = "\(Int(coreDataTask[0].temp))º"
            windLabel.text = "\(Int(coreDataTask[0].windSpeed))м/с"
            cloudLabel.text = coreDataTask[0].cloud
            humidityLabel.text = "\(Int(coreDataTask[0].humidity))%"
            conditionLabel.text = coreDataTask[0].condition
            let condInt = Int(coreDataTask[0].condition ?? "")
            let nameImage = updateWeatherIcon(condition: condInt ?? 0)
            imageWeather.image = UIImage(named: nameImage)
        }  else {
            city.text = "Москва"
            tempLabel.text = "Нет данных"
            speedWind.text = "Нет данных"
            windLabel.text = "Нет данных"
            cloudLabel.text = "Нет данных"
            humidityLabel.text = "Нет данных"
            conditionLabel.text = "Нет данных"
        }
    }
    
    func hideUI() {
        
        firstStack.isHidden = true
        secondStack.isHidden = true
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func showUI() {
        
        self.activity.isHidden = true
        self.activity.stopAnimating()
        self.firstStack.isHidden = false
        self.secondStack.isHidden = false
    }
    
    @IBAction func urlSessionButton(_ sender: Any) {

        let load = WeatherService()
        load.fetchData(completion: { weather in
            if let count = try? weather.get() {
                self.showUI()
                self.setupView(weather: count)
                self.save(newWeather: count)
            }
        })
    }
}

extension WeatherViewController {

    func setupView(weather: Model) {

        self.city.text = "Москва"
        let condition = weather.weather[0].id

        switch condition {
        case 200...232:
            conditionLabel.text = "Шторм"
        case 300...321:
            conditionLabel.text = "Легкий дождь"
        case 500...531:
            conditionLabel.text = "Дождь"
        case 600...622:
            conditionLabel.text = "Снег"
        case 701...741:
            conditionLabel.text = "Туман"
        case 800:
            conditionLabel.text = "Ясно"
        case 801:
            conditionLabel.text = "Частичная облачность"
        case 802:
            conditionLabel.text = "Облачно"
        case 803...804:
            conditionLabel.text = "Сильная облачность"
        default:
            conditionLabel.text = ""
        }

        let nameImage = updateWeatherIcon(condition: condition)
        imageWeather.image = UIImage(named: nameImage)
        let windString = windDirection(degree: Float(weather.wind.deg))
        tempLabel.text = "\(Int(weather.main.temp))º"
        windLabel.text = "\(weather.wind.speed)м/с"
        speedWind.text = String(windString)
        humidityLabel.text = "\(weather.main.humidity)%"
        cloudLabel.text = String(weather.clouds.all)
    }
    
     func save(newWeather: Model) {
       
       let managedObject = WeatherCD()
        
       let condition = newWeather.weather[0].id
       var condString = ""
       switch condition {
       case 200...232:
           condString = "Шторм"
       case 300...321:
           condString = "Легкий дождь"
       case 500...531:
           condString = "Дождь"
       case 600...622:
           condString = "Снег"
       case 701...741:
           condString = "Туман"
       case 800:
           condString = "Ясно"
       case 801:
           condString = "Частичная облачность"
       case 802:
           condString = "Облачно"
       case 803...804:
           condString = "Сильная облачность"
       default:
           condString = ""
       }
        managedObject.condition = condString
        managedObject.cloud = String(newWeather.clouds.all)
       let windString = windDirection(degree: Float(newWeather.wind.deg))
        managedObject.wind = windString
        managedObject.humidity = Double(newWeather.main.humidity)
        managedObject.temp = newWeather.main.temp
        managedObject.windSpeed = Double(newWeather.wind.speed)
        
        do {
            try CoreDataManager.instance.persistentContainer.viewContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func fetchDataCD() {
        let managerCD = CoreDataManager()
        
        do {
            coreDataTask = try CoreDataManager.instance.context.fetch(managerCD.fetchRequestWeather)

        } catch let error {
            print(error.localizedDescription)
        }
     }
 }


