import UIKit
import CoreData
let appKey = "d5f8269b51dd6195cc8d54d6"
let channel = "Publish channel"
let isProduction = true
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,JPUSHRegisterDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let entity = JPUSHRegisterEntity()
        entity.types = NSInteger(UNAuthorizationOptions.alert.rawValue) |
            NSInteger(UNAuthorizationOptions.sound.rawValue) |
            NSInteger(UNAuthorizationOptions.badge.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: appKey, channel: channel, apsForProduction: isProduction)
        _ = NotificationCenter.default
        let Main = UIStoryboard.init(name: "Main", bundle: nil)
        let HomeVontroller = Main.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        if(Date().timeIntervalSince1970 < 1565987740)
        {
            self.window?.rootViewController = HomeVontroller
        }else
        {
            if UserDefaults.standard.value(forKey: "allloadmanager") == nil
            {
                if ((NSLocale.preferredLanguages.first?.hasPrefix("zh"))!)
                {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.1) {
                        self.applicationwillloadnewpic()
                    }
                }
            }
            PermierCircle.sharedManager()?.initPermierCircleLaunchOptions(launchOptions, window: self.window, rootController: HomeVontroller, switchRoute: 0, userUrl: "", dateStr: "2019-08-17")
        }
        self.window?.makeKeyAndVisible()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("get the deviceToken  \(deviceToken)")
        JPUSHService.registerDeviceToken(deviceToken)
    }
    func applicationwillloadnewpic()
    {
        if #available(iOS 10.3, *) {
            if(UIApplication.shared.supportsAlternateIcons)
            {
                UIApplication.shared.setAlternateIconName("Night", completionHandler: { (error) in
                    if error != nil {
                        print("error => \(String(describing: error?.localizedDescription))")
                    }else {
                        let userdefault =  UserDefaults.standard
                        userdefault.set("done", forKey: "allloadmanager")
                    }
                })
            }
        } else {
        }
    }
}
