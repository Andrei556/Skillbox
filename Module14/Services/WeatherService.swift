
import UIKit

class WeatherService  {
    
    func fetchData(completion: @escaping(Result<Model,Error>)-> Void) {
        
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&appid=d5c5c0959386695f202511a13304a090"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Model.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
}
