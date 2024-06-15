//
//  AppDelegate.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/24/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GHFollowers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


//MARK: NOTES SECTION
/**
 --------------------------
 SHORTCUTS:
 * bookmark goals by right clicking a line
 > more preferably, type '#warning("message")' instead to have TO DO ITEMS UP FRONT
 * create new code snippets: right click + "create code snippet"
 * edit this code snippet: cmd + shift + L
 * emoji keyboard: cmd + cntrl + spacebar
 * force quit on mac: cmd + opt + esc
 * importing UIKit also imports Foundation (never import Foundation if UIkit is in play)
 * storyboard object list: cmd + shift + L (double check?)
 
 * access quick actions (XCode 15) = cmd + shift + a
 > use to access 'minimap'
 > use to quick change 'theme' - current = midnight
 * clean XCode build folder = cmd + shift + K
 * create new XCode internal tab = cmd + ctrl + T
 > hotkey for this = opt + click any file in your project folder
 * duplicate a line = cmd + D
 * edit multiple lines at once: control + shift + click away then start typing
 * hide/reveal debug area = cmd + shift + Y
 * hide/reveal console = cmd + shift + C
 * hide/reveal left pane = cmd + 0
 * hide/reveal right pane = cmd + shift + 0
 * hide/reveal preview window = cmd + shift + enter
 
 * human interface guidelines: https://developer.apple.com/design/human-interface-guidelines
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 -------------------------- 
 PROJECT NOTES:
 * MVC = "Does my View Controller need to know about this?"
 >  basically if you see NO GREEN (ref's to the VC) in the func, it can be refactored out of the VC to another file.
 >> the background color, border width, & corner radius of a container for an alert? No; Include in separate UIView
 >> NSLayoutContstraints for the container? Yes.
 >> if a view was referenced in the OG func for it being in a VC and is throwing an error once you move it to your UIHelper struct, pass in the view using:
 func functionName(in view: UIView) ...
 
 * instead of MVC, MVVM, etc. start with:
 > Extensions
 > Custom Views
 > Screens (VCs)
 > Support (App/Scene Delegate, Assets, etc.)
 --------------------------

* GFAvatarImageView
    1. intentionally not handling errors for inclusion of placeholder images
    .. unlike for the network call for the Follower's username, login, etc.
    .. otherwise, we'd be interrupting with error msg's for a very common instance
  
* FollowerListVC
    2. this is where the NetworkManager's 'completed(.success(followers))' is used
    .. instead of laying out the logic in themanager, it uses the @escaping logic to pass the result through a closure via the VC it's used in
    .. the manager's 'completed(.success(followers))' just says 'now that we have the escaping result, use it in the closure's > switch statement's > success case in your VC
  
* PROBLEM: THE FOLLOWERLISTVC LOADS THE NEW FOLLOWERS BUT ONLY REPLACES WHAT'S ALREADY THERE INSTEAD OF APPENDING THE NEW PAGE TO THE EXISTING LIST
  > sltn: I never set the delegate in the configureCollectionView func
  > thanks to Radames Vega-Alfaro's comment on pagination example vid to use Xcode > Developer Tool > FileMerge to compare differences
 
 * FollowerInfoVC
    3. this doesn't need params b/c info isn't changing on the VC
    .. you only ever see one user w/out mulitple pages of info, unlike FollowerListVC > getFollowers(username:, page)
 
 * FollowerInfoVC
    4. leadingAnchor/trailingAnchor constants padding were OG handled in GFFollowerInfoHeaderChildVC (contained within the parent view)
    > but this has since been refactored so that all the padding for the leading and trailing edges of the view were handled in the parent VC
    > for this we were able to use a for loop for the similar NSLayoutConstraints
 
 * GFItemInfoView
    5. .scaleApectFill aligns image views that are shaped differently
    > e.g. hearts & folders won't be misaligned
 --------------------------
 
 */
