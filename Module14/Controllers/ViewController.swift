
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameLabel: UITextField!
    
    let nameKey = "nameTextValue"
    let surnameKey = "surnameTextValue"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadValue()
        self.nameLabel.delegate = self
        self.surnameLabel.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func loadValue() {

        nameLabel.text = UserDefaults.standard.string(forKey: nameKey)
        surnameLabel.text = UserDefaults.standard.string(forKey: surnameKey)
    }

   private func textFieldShouldReturn(textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        UserDefaults.standard.set(nameLabel.text, forKey: nameKey)
        UserDefaults.standard.set(surnameLabel.text, forKey: surnameKey)
        textFieldShouldReturn(textField: nameLabel)
    }
}
