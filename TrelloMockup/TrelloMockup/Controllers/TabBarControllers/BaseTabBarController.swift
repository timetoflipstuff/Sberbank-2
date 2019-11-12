//
//  BaseTabBarController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        
        let tasksViewController = UINavigationController(rootViewController: ViewController(collectionViewLayout: layout))
        tasksViewController.tabBarItem = UITabBarItem(title: "Задачи", image: UIImage(named: "tasks"), tag: 0)
        
        let notesViewController = UINavigationController(rootViewController: NotesViewController())
        notesViewController.tabBarItem = UITabBarItem(title: "Заметки", image: UIImage(named: "notes"), tag: 1)
        
        
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        settingsViewController.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "settings"), tag: 2)
        
        viewControllers = [tasksViewController, notesViewController, settingsViewController]
    }
    

}
