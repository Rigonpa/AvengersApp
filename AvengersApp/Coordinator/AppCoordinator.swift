//
//  AppCoordinator.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let dataProvider: DataProvider = {
        let dataProvider = DataProvider()
        return dataProvider
    }()
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let tabBarController = UITabBarController()
        
        // Heroes module
        let heroesNavigationController = UINavigationController()
        let heroesCoordinator = HeroesCoordinator(presenter: heroesNavigationController, dataProvider: dataProvider)
        addChildCoordinator(coordinator: heroesCoordinator)
        heroesCoordinator.start()
        
        // Combats module
        let combatsNavigationController = UINavigationController()
        let combatsCoordinator = CombatsCoordinator(presenter: combatsNavigationController, dataProvider: dataProvider)
        addChildCoordinator(coordinator: combatsCoordinator)
        combatsCoordinator.start()
        
        // Villains module
        let villainsNavigationController = UINavigationController()
        let villainsCoordinator = VillainsCoordinator(presenter: villainsNavigationController, dataProvider: dataProvider)
        addChildCoordinator(coordinator: villainsCoordinator)
        villainsCoordinator.start()
        
        tabBarController.viewControllers = [heroesNavigationController,
                                            combatsNavigationController,
                                            villainsNavigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        // Tab bar UI design
        settingUpTabBar(tabBarController)
    }
    
    override func finish() {}
    
    private func settingUpTabBar(_ tabBarController: UITabBarController) {
        
        // Increasing tab bar item image and moving it down 5 inches (vertical center in the tab bar)
        let tabBarSize = CGSize(width: 28, height: 28)
        
        guard let heroesTabBarImage = UIImage(named: "ic_tab_heroes") else { return }
        let heroesScaledImage = resizeImage(image: heroesTabBarImage, targetSize: tabBarSize)
        tabBarController.viewControllers![0].tabBarItem = UITabBarItem(title: "", image: heroesScaledImage, tag: 0)
        tabBarController.viewControllers![0].tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        guard let combatsTabBarImage = UIImage(named: "ic_tab_battles") else { return }
        let combatsScaledImage = resizeImage(image: combatsTabBarImage, targetSize: tabBarSize)
        tabBarController.viewControllers![1].tabBarItem = UITabBarItem(title: "", image: combatsScaledImage, tag: 1)
        tabBarController.viewControllers![1].tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        guard let villainsTabBarImage = UIImage(named: "ic_tab_villain") else { return }
        let villainsScaledImage = resizeImage(image: villainsTabBarImage, targetSize: tabBarSize)
        tabBarController.viewControllers![2].tabBarItem = UITabBarItem(title: "", image: villainsScaledImage, tag: 2)
        tabBarController.viewControllers![2].tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.02531321719, green: 0.4073432684, blue: 0.903057158, alpha: 1)
        tabBarController.tabBar.itemPositioning = .centered
        tabBarController.tabBar.itemWidth = 100
        
        UINavigationBar.appearance().overrideUserInterfaceStyle = .light
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.548281312, green: 0.7027081847, blue: 0.9476903081, alpha: 1) // AWESOME
    }
}
