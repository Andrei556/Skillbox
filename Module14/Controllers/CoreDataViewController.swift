
import UIKit

class CoreDataViewController: UITableViewController {
    
    var coreDataTasks: [Task] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coreDataTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let item = coreDataTasks[indexPath.row]
        cell.textLabel?.text = coreDataTasks[indexPath.row].task
        cell.tintColor = item.isDone ? .green : .green
        cell.accessoryType = item.isDone ? .checkmark: .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {

            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            self.coreDataTasks[indexPath.row].isDone = true
            self.tableView.reloadRows(at: [indexPath], with: .none)
            let actionMenu = UIAlertController(title: nil, message: "Задача выполнена!", preferredStyle: .alert)

           self.present(actionMenu, animated: true, completion: nil)
           dismiss(animated: true, completion: nil)
            
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                self.coreDataTasks[indexPath.row].isDone = false
                self.tableView.reloadRows(at: [indexPath], with: .none)
                let actionMenu = UIAlertController(title: nil, message: "Задача отменена!", preferredStyle: .alert)
    
               self.present(actionMenu, animated: true, completion: nil)
                dismiss(animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let task = coreDataTasks[indexPath.row]
        if editingStyle == .delete {
            deleteTask(task, indexPath: indexPath)
        }
    }
    
    private func deleteTask(_ task: Task, indexPath: IndexPath) {
        
        CoreDataManager.instance.context.delete(task)
        do {
            try CoreDataManager.instance.context.save()
            coreDataTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        let alert = UIAlertController(title: "Новая задача", message: "Введите новую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            let task = alert.textFields?.first
            if let task = task?.text{
                self.save(task)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
        do {
            try CoreDataManager.instance.context.save()
            
            } catch let error as NSError {
                print(error.localizedDescription)
        }
    }
    
    private func save(_ taskName: String) {
        
        let managedObject = Task()
        managedObject.task = taskName
        
        do {
            try CoreDataManager.instance.context.save()
            coreDataTasks.append(managedObject)
            self.tableView.insertRows(at: [IndexPath(row: self.coreDataTasks.count - 1, section: 0)], with: .automatic)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchData() {
        let managerCD = CoreDataManager()

        do {
            coreDataTasks = try CoreDataManager.instance.context.fetch(managerCD.fetchRequestTask)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
