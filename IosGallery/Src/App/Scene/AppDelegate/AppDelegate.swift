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
    var userManager: UserManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        CocoaDebug.enable()
        //            DBDebugToolkit.setup()
        #endif
        IQKeyboardManager.shared().isEnabled = true
        DI.initDependencies()
        openStartScreen(window: window)
        userManager = DI.resolve()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
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
        let rootVC = R.storyboard.root.rootVC()!
        if let userManager = userManager, userManager.token != nil, userManager.user != nil {
            window.rootViewController = rootVC
        } else {
            window.rootViewController = loginVC
        }
        Theme.current.setActive()
        window.makeKeyAndVisible()
    }

    func doLogOut() {
        guard let userManager = userManager else { return }
        userManager.token = nil
        userManager.user = nil
        guard let window = window else { return }
        let loginVC = R.storyboard.login.loginVC()!
        window.rootViewController = loginVC
    }
    
}

