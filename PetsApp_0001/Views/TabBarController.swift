//
//  TabBarController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 12.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    private enum TabBarItem: Int {
        case calendar
        case journal
        case pets
        case settings
        
        var title: String {
            switch self {
            case .calendar:
                return "calendar".localized
            case .journal:
                return "journal".localized
            case .pets:
                return "pets".localized
            case .settings:
                return "settings".localized
            }
        }
        
        var iconName: String {
            switch self {
            case .calendar:
                return "calendar"
            case .journal:
                return "newspaper"
            case .pets:
                return "pawprint"
            case .settings:
                return "gearshape"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.calendar, .journal, .pets, .settings]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .calendar:
                let calendarViewController = CalendarAssembly.build()
                return self.wrappedInNavigationController(with: calendarViewController, title: $0.title)
            case .journal:
                let journalViewController = JournalAssembly.build()
                return self.wrappedInNavigationController(with: journalViewController, title: $0.title)
            case .pets:
                let petsViewController = PetsAssembly.build()
                return self.wrappedInNavigationController(with: petsViewController, title: $0.title)
            case .settings:
                let settingsViewController = SettingsAssembly.build()
                return self.wrappedInNavigationController(with: settingsViewController, title: $0.title)
            }
        }
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
        
        tabBar.tintColor = .systemPink
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .systemBackground
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
        return UINavigationController(rootViewController: with)
    }
}
