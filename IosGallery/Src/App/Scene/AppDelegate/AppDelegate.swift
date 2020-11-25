//
//  AppDelegate.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit
import IQKeyboardManager
#if DEBUG
import CocoaDebug
//    import DBDebugToolkit
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let shared = (UIApplication.shared.delegate as! AppDelegate)
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        CocoaDebug.enable()
        //            DBDebugToolkit.setup()
        #endif
        IQKeyboardManager.shared().isEnabled = true
        DI.initDependencies()
        openStartScreen(window: window)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
        }
        
    }
    
    func openStartScreen(window: UIWindow?) {
        self.window = window
        guard let window = self.window else { return }
        let loginVC = R.storyboard.login.loginVC()
        //        let rootVC = R.storyboard.root().instantiateInitialViewController()
        //        let rootVC = R.storyboard.root.rootVC()!
        //        let rootVC = R.storyboard.login.loginVC()!
        window.rootViewController = loginVC
        //        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
    
}

