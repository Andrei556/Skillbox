

import RealmSwift

let realm = try! Realm()

struct StorageManager {
    
    var tasksList: Results<ModelRealm>! = nil

    static func save(task: ModelRealm) {
        
        try! realm.write {
            realm.add(task)
        }
    }
}
