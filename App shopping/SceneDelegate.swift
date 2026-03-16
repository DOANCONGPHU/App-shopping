//
//  SceneDelegate.swift
//  App shopping
//
//  Created by gem on 12/3/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //tab1
        let homeVC = HomeViewController()
        let nav1 = UINavigationController(rootViewController: homeVC)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        //tab2
        let favVC = FavouriteViewController()
        let nav2 = UINavigationController(rootViewController: favVC)
        nav2.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart") , tag: 1)
        //tab3
        let inboxVC = InboxViewController()
        let nav3 = UINavigationController(rootViewController: inboxVC)
        nav3.tabBarItem = UITabBarItem(title: "Inbox", image: UIImage(systemName: "envelope"), tag: 2)
        //tab4
        let cartVC = CartViewController()
        let nav4 = UINavigationController(rootViewController: cartVC)
        nav4.tabBarItem = UITabBarItem(title: "Cart", image:UIImage(systemName:  "cart"), tag: 3)
        //tab5
        let profileVC = ProfileViewController()
        let nav5 = UINavigationController(rootViewController: profileVC)
        nav5.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 5)
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [nav1,nav2,nav3,nav4,nav5]
        
        tabBar.tabBar.tintColor = .systemBlue
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemPurple
        tabBar.tabBar.standardAppearance = appearance
        
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

