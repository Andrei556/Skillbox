
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameLabel: UITextField!
    
    let nameKey = "nameTextValue"
    let surnameKey = "surnameTextValue"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadValue()
    }
    
    private func loadValue() {

        nameLabel.text = UserDefaults.standard.string(forKey: nameKey)
        surnameLabel.text = UserDefaults.standard.string(forKey: surnameKey)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        UserDefaults.standard.set(nameLabel.text, forKey: nameKey)
        UserDefaults.standard.set(surnameLabel.text, forKey: surnameKey)
    }
}
