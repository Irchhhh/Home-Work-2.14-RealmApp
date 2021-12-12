//
//  StorageManager.swift
//  RealmApp
//
//  Created by Alexey Efimov on 08.10.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Task List
    func done(_ tasks: Task) {
        write {
            tasks.isComplete.toggle()
        }
    }
    
    func edit(_ tasks: Task, newValue: String) {
        write {
            tasks.name = newValue
        }
    }
    func save(_ taskLists: [TaskList]) { //сохраняет несколько списков
        write {
            realm.add(taskLists) //записать списки в базу
        }
    }
    
    func save(_ taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    func delete(_ tasks: Task) {
        write {
            realm.delete(tasks)
        }
    }
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }

    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }
    

    // MARK: - Tasks
    func save(_ task: Task, to taskList: TaskList) { // Добавление новой задачи
        write {
            taskList.tasks.append(task)
        }
    }
    
    private func write(completion: () -> Void) { //Запись в базу
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
        
    }
}



