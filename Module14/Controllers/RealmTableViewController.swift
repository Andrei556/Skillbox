
import UIKit

class RealmTableViewController: UITableViewController {
    
    var realmModel = StorageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmModel.tasksList = realm.objects(ModelRealm.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return realmModel.tasksList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = realmModel.tasksList[indexPath.row].task
        
        let item = realmModel.tasksList[indexPath.row]
        cell.tintColor = item.completed ? .green : .green
        cell.accessoryType = item.completed ? .checkmark: .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        let selectedRow:UITableViewCell = tableView.cellForRow(at: indexPath)!

        if selectedRow.accessoryType == UITableViewCell.AccessoryType.none {

            selectedRow.accessoryType = UITableViewCell.AccessoryType.checkmark

        } else {

            selectedRow.accessoryType = UITableViewCell.AccessoryType.none
    }
        let item = realmModel.tasksList[indexPath.row]
        try! realm.write {
                item.completed = !item.completed
            }
        
        tableView.deselectRow(at: indexPath, animated: true)
}

    @IBAction func addTask(_ sender: Any) {
        
    let alert = UIAlertController(title: "Новая задача", message: "Введите новую задачу", preferredStyle: .alert)
    let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
        guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
        let realm = ModelRealm()
        realm.task = task
        StorageManager.save(task: realm)
        self.tableView.insertRows(at: [IndexPath(row: self.realmModel.tasksList.count - 1, section: 0)], with: .automatic)
    }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let task = realmModel.tasksList[indexPath.row]
        
        try! realmModel.tasksList.realm?.write {
            realmModel.tasksList.realm?.delete(task)
            tableView.reloadData()
        }
    }
    
}
