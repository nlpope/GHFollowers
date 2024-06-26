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
 swift @ version: 5.10.1
 xcode @ version: 15.4
 --------------------------
 SHORTCUTS (GENERAL):
 
 *  access quick actions (XCode 15) = cmd + shift + a
    > use to access 'minimap'
    > use to quick change 'theme' - current = midnight
 *  bookmark goals by right clicking a line
    > more preferably, type '#warning("message")' instead to have 'return to' items clear & present
 *  clean XCode build folder = cmd + shift + K
 *  create new code snippets: right click + "create code snippet"
 *  duplicate a line = cmd + D
 *  edit multiple lines at once: control + shift + click away then start typing
 *  edit this / saved code snippet: cmd + shift + L
 *  emoji keyboard: cmd + cntrl + spacebar
 *  force quit on mac: cmd + opt + esc
 *  importing UIKit also imports Foundation (never import Foundation if UIkit is in play)
 *  new XCode internal tab = cmd + ctrl + T
    > hotkey for this = opt + click any file in your project folder
 *  storyboard object list: cmd + shift + L (double check?)
 
 SHORTCUTS (HIDE / REVEAL PANES):
 
 *  hide/reveal debug & console area = cmd + shift + Y
 *  hide/reveal left pane = cmd + 0
 *  hide/reveal right pane = cmd + shift + 0
 *  hide/reveal preview window = cmd + shift + enter
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 
 HELPFUL TIPS:
 
 *  Code formatting:
    > order = vars/lets, init methods, view lifecycle methods (VDL), funcs
    > 1 space after imports
    > 1 space after class / struct / enum declarations
    > 2 spaces after vars just before methods
    > 2 spaces between funcs
    >> no spaces on 1st line after func declaration

 *  Debugging
    > see Stanford: https://www.youtube.com/watch?v=CRxHhx_pubY&list=PL3d_SFOiG7_8ofjyKzX6Nl1wZehbdiZC_&index=3&ab_channel=CS193P
 
 *  DispatchQueue-ing to main thread:
    > updating UI? - switch to main thread
    >> ex: DispatchQueue.main.async { self.image = image }
 
 *  Folders = instead of MVC, MVVM, etc. start with:
    > Extensions - "...+Ext"
    > Utilities (error msgs, constant enums, UIHelpers) - "...+Utils"
    > Managers
    > Models
    > CustomViews
    > Screens (VCs)
    > Support (App/Scene Delegate, Assets, the rest)
    >> except info.plist, leave this outside/alone
 
 *  Human interface guidelines: https://developer.apple.com/design/human-interface-guidelines
 
 *  MVC = "Does my View Controller need to know about this?"
    >  basically if you see NO GREEN TEXT (ref's to props created in the VC) in the func, it can be refactored to another file.
    >> the background color, border width, & corner radius of a container for an alert? No; Include in separate UIView
    >> NSLayoutContstraints for the container? Yes.
    >> if a refactored view was referenced in the OG func and is throwing an error once you move it, pass in the view using: func functionName(in view: UIView) { }
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 
 PROJECT NOTES:
 
* GFAvatarImageView
    1. intentionally not handling errors for inclusion of placeholder images
    .. unlike for the network call for the Follower's username, login, etc.
    .. otherwise, we'd be interrupting with error msg's for a very common instance
    .. this is why we don't need a result type returned from the escaping closure
    > result types send an object in success cases & an error in failures (something we have no use for, given the placeholder image's communicating the same thing)
  
* FollowerListVC
    2. this is where the NetworkManager's 'completed(.success(followers))' is used
    .. instead of laying out the logic in themanager, it uses the @escaping logic to pass the result through a closure via the VC it's used in
    .. the manager's 'completed(.success(followers))' just says 'now that we have the escaping result, use it in the closure's > switch statement's > success case in your VC
  
* PROBLEM: THE FOLLOWERLISTVC LOADS THE NEW FOLLOWERS BUT ONLY REPLACES WHAT'S ALREADY THERE INSTEAD OF APPENDING THE NEW PAGE TO THE EXISTING LIST
  > sltn: I never set the delegate in the configureCollectionView func
  > thanks to Radames Vega-Alfaro's comment on pagination example vid to use Xcode > Developer Tool > FileMerge to compare differences
 
 * UserInfoVC
    3. this doesn't need params b/c info isn't changing on the VC
    .. you only ever see one user w/out mulitple pages of info, unlike FollowerListVC > getFollowers(username:, page)
 
 * FollowerInfoVC
    4. leadingAnchor/trailingAnchor constants padding were OG handled in GFUserInfoHeaderChildVC (contained within the parent view)
    > but this has since been refactored so that all the padding for the leading and trailing edges of the view were handled in the parent VC
    > for this we were able to use a for loop for the similar NSLayoutConstraints
 
 * GFItemInfoView
    5. .scaleApectFill aligns image views that are shaped differently
    > e.g. hearts & folders won't be misaligned
 
 * GFItemInfoSuperVC
    6. this generic SUPER CLASS puts both the UIViews & UIbutton together
    > it does all the HEAVY LIFTING for the more specific GFRepo/FollowerItemChildVCs
    > making the setup short for both SUBCLASSES (above)
    >> all you have to call is the "set( )" func for each childVC & the button (genericVC [collects UIViews & UIButton w set( ) funcs] > specificVC > finalChildVC)
    > ... and even shorter in the UserInfoVC it's used in
 
 * UserInfoVC
    7. refactored this so the network call's success reads simpler / cleaner
    > also, we needed access to the '.delegate' property after initializing the user
    >> this is not cleanly / done in the network call, so it's another reason it was refactored out into its own func.
    >> also for this reason, we no longer need to initialize the GFRepo/FollowerItemChildVC subclasses in the 'self.add' method
    
    > UPDATE: this was further refactored so that the delegate is initialized along with the user from their respective VCs
    >> this was done purely for readability / aesthetic
 
 * PersistenceManager
    8. enum is used instead of struct for one minor difference: you can initialize an empty struce; you cannot initialize an empty enum
    
    9. see how the @escaping func returns either nil or a GFError (GFError?). Notice how the save(favorites: ) function we're calling at the end of the add or remove action type returns the same value.
    > PROBLEM: I struggled getting the "user was successfully saved" message
    >> sltn: I didn't wrap the save(favorites: retrievedFavorites) in a completed( )
    >> i.e. I didn't send the result of my call to 'save(favorites: )' to the escaping completion handler
 
 *  FavoriteCell & FavoritesListVC
    10. in FavoritesListVC we hard code the tableView to be 80 pts tall ...
    > so the imgView it will contain is set to 60 to leave space in btwn the img & cell's upper & lower padding
 
 *  FavoritesListVC
    11. since the UI is communicating the success case (swipe to delete verification = row disapears), we can safely 'return' if no error takes place during deletion
    > it's not like we're going to put up a notif. onscreen telling the user the deletion was successful if the UI did that work for us
 
 *  SearchVC
    12. replacing logo's variable top constraint (via Sean Allen's Constants+Utils > ScreenSize) method with Jonathan Rasmusson's UIViewController+Ext method
    > YT source: https://www.youtube.com/watch?v=O4tP7egAV1I&ab_channel=SwiftArcade
    > Git source: https://github.com/jrasmusson/ios-professional-course/blob/main/Password-Reset/7-Dealing-Keyboards/README.md
    > Docs on iOS coord. system: https://developer.apple.com/library/archive/documentation/General/Conceptual/Devpedia-CocoaApp/CoordinateSystem.html
 
 *  UIViewController+Ext
    13. this custom UIResponder utility was created in Utilities > UIResponder+Utils
    > its purpose is to pinpoint which UIResponder triggered the keyboard (e.g. UISearchBarTextField: 0x10386be00) and determine its frame / location
 
 * UIResponder+Utils
    14. purpose = @ present, there's no simple func or extension to determine which textfield triggered the keyboard (first responder), so we'll have to do this manually by:
    > 1. getting the textField's info with the custom '.currentResponder( )'  UIResponder extension
    > 2. determining whether the text field will be blocked @ the end of the keyboard's animating in
    >> note: I'm unsure if converting the currentTextField's frame relative to the superview was necessary, I got the same values when printing them out
    >> assumption was correct, docs says 'a view's frame prop already expresses location relative to superview', so I omitted the conversion bit
    >> works as expected on both iphone 15 pro & iphone SE
    >> I also changed some confusing/inconsistent var names (e.g. textBoxY > textFieldTopY)
 
    > 3. then adjusting the view up if so
 
 *  NetworkManager
    15. in the 'else { return } bits, we can no longer let the 'return' sit alone
    > the completion is expecting either a UIImage or nil - mind the '(UIImage?)' in its declaration
    > ... for this, when a guard statement fails we must write 'completed(nil)' before the return
    > ... when a guard statement passes we must write 'completed(image)' before the return
    > ... but simply writing return on a fail is not allowed
 
 * GFDataLoadingVC
    16. containerView can be held in local scope (past the imports section) & taken out of 'fileprivate' status, because this is a  specific class and no longer an extension of all VCs
    > now, any children / subclasses of this new class have access to both the VC type's extensions AND the funcs specific to those VCs that potentially show a loading spinner
    > change is because not all VCs need to show a loading view (i.e. searchVC)
 
 * FollowerListVC
    17. Why is [weak self] not captured in DispatchQueue?
    > you geneerally don't need to worry about retain cycles with DispatchQueue, as the cycle is temporary in DispatchQueue's methods. This makes [weak self] unnecessary
    > source: https://stackoverflow.com/questions/41991467/where-does-the-weak-self-go
    > source (more clear, see comment by Tera): https://forums.swift.org/t/retain-cycle-with-disptachqueue/63791/3
 
 *  GFAlertChildVC
    18. these subviews were originally added in their respective configure funcs
    > however we can easily add them all in the viewDidLoad
    > just be mindful of those views added with respect to the containerView
    > NOTE: only do that in the VDL if the subviews are being added in different funcs. Not in different funcs? call custom addSubviews inside the one func it's being called in originally
 
 * FollowerListVC
    19. @ present theres isn't a way to get the VC's title back after  a search unless the 'cancel' button is clicked
    > ... there doesn't seem to be a way to programmatically trigger the behavior tied to the searchBarCancelButtonClicked delegate method once the user deletes the final character from a seach
    > when I try and dismiss the search bar @ the 'textDidChange' method for the instance where the user backspaced all the way, I'm able to dismiss the keyboard by using either the 'resignFirstResponder() or endEditing() props on the searchBar
    > ... but I'm unable to cancel the search entirely & I lose the title in the VC
    > closest sltn's I could find only related to SwiftUI
 
    20. There was no way to get back to the user info VC should one want to see that collection of info laid out again from the followerListVC
    > so I added another bar button item to the navigation controller to jump to it
    > no need to make a network call, unlike 'adding to favorites' button, the info needed for the UserInfoVC is gathered within that VC using the same method
    > ... this is also why we need not show the loading view - all that's handled in the next UserInfoVC's network call (dismissal included)
    > ... NetworkManager's getUserInfo is only necessary up top to gather the @ present unavailable avatar image used to configure the user's favorite cell
 
*   GFBodyLabel
    21. adjustsFontForContentSizeCategory allows the text size to change depending on the text size on the user's phone - ALWAYS INCLUDE THIS IN BODY LABELS
    > you can test for this using the environment overrides (img of 2 sliders on xcode's bottom left) & sliding the 'Dynamic Type' scale
 
 *  FavoriteCell
    22. There was a PROBLEM; The cells were displaying recycled images the first time favorites tab is visited, so the wrong profile pic would appear next to the name
    > SOLVE: setting the imageView in the favorite cell to Image.placeholder just before we download the image - This prevented me from seeing the old picture in the dequeued reusable cell (from old scrolls I'm assuming)
    > note that the cache that was implemented also helps with this when the image was already downloaded
 
 *  UserInfoVC
    23. this is where you can test the view containers before filling them with view by tinkering with the background colors. For example:
    > itemViewOneContainer.backgroundColor = .systemPink
    > itemViewTwoContainer.backgroundColor = .systemBlue
 
 *  UserInfoVC
    24. finish researching & implementing UIView.fitToSize( )
    > see 'iPhone SE - UserInfoVC Fixes' video
    >> Abdulaziz Alobaili's comment
    
 
 --------------------------
 
 */
