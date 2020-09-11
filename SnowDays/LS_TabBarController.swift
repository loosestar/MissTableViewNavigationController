//
//  LS_TabBarController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 24/12/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

class LS_TabBarController: UITabBarController, UITabBarControllerDelegate {
    
//    let alert: UIAlertController = UIAlertController(title: "gogogo", message: "hrmph", preferredStyle: .actionSheet)
//    let action: UIAlertAction = UIAlertAction(title: "Item", style: .default)
    var modelController: LS_DataController!
    var tableDelegate: LS_DataTableViewController!
    var trip: UIActivityViewController = UIActivityViewController(activityItems: ["Trip"], applicationActivities: [])
//    let trip: LS_DataDetailViewController = LS_DataDetailViewController()
    let crew: UIActivityViewController = UIActivityViewController(activityItems: ["Crew"], applicationActivities: [])
    let media: LS_MediaViewController = LS_MediaViewController()
    let share: UIActivityViewController = UIActivityViewController(activityItems: ["Share"], applicationActivities: [])
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
    
//    var detailVC: LS_DataDetailViewController?
    
    private var initialData: LS_Utilities!
    private var dataArray = [LS_Data]()
    
    var activeIndex: Int!
    
    private var firstLaunch: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad LS_TabBarController()")
        
        self.delegate = self
//        self.tabBarController?.delegate = self
        
//        self.alert.addAction(self.action)
//        self.alert.addAction(self.cancelAction)
        
        
        modelController = LS_DataController()
        
        initialData = LS_Utilities.init()
        dataArray = initialData.allData()
        
        modelController.dataStructure = dataArray
//        dataSource = LS_DataTableViewDataSource(data: tableData, reuseIdentifier: "LS_TableViewCell")
        
        let firstViewController = UIViewController()
//        detailVC = LS_DataDetailViewController()
        
        // create a tabBarItem representing the object's viewController
//        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        firstViewController.tabBarItem = UITabBarItem(title: "Trip", image: UIImage(named: "Snow"), tag: 0)
//        detailVC!.tabBarItem = UITabBarItem(title: "Trip", image: UIImage(named: "Snow"), tag: 0)
        
        let secondViewController = UIViewController()
//        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        secondViewController.tabBarItem = UITabBarItem(title: "Crew", image: UIImage(named: "Person3.fill"), tag: 1)
        
        let thirdViewController = UIViewController() //self.media //LS_MediaViewController() //UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Media", image: UIImage(named: "PhotoOnRectangle"), tag: 2)
        
        let fourthViewController = UIViewController()
//        fourthViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        fourthViewController.tabBarItem = UITabBarItem(title: "Share", image: UIImage(named: "SquareArrowUp"), tag: 3)
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        
        self.viewControllers = tabBarList.map { UINavigationController(rootViewController: $0) }
        
        // attempting to set a default tab/viewController
        if (firstLaunch == true) {
            firstLaunch = false
            activeIndex = 0
            self.tabBarController?.selectedIndex = activeIndex
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("selected tab \(item.tag)")
        
        // TODO: The rootViewController should be the active view controller
//        var navController: UINavigationController = UINavigationController(rootViewController: trip)
        
        switch item.tag {
        case 0:
            
//            trip.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//            trip.dataIndex = self.activeIndex
//            trip.prepareView()
//            self.present(trip, animated: true, completion: nil)
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let tbController = LS_TabBarController()
            
            print("detail \(activeIndex ?? -1) selected")
    //        performSegue(withIdentifier: "LS_DetailSegue", sender: tableView)
            let detailVC = LS_DataDetailViewController()
            detailVC.delegate = tableDelegate
//            detailVC.modalPresentationStyle = UIModalPresentationStyle.automatic
    //        detailVC.modalPresentationStyle = .pageSheet // detail should be fullscreen!
            if (detailVC.detailData/*modelController*/ == nil) {
//                detailVC.loadData() // OR, assign it the model controller in this object? YES
                print("setting modelController for new detailView")
                print("its dataStructure is...\(self.modelController.dataStructure.count)")
//                detailVC.modelController = self.modelController
                detailVC.detailData = self.modelController.dataStructure[activeIndex]
            } else {
                print("interestingly detailData is already set. \(detailVC.detailData.id)")
            }
//            tbController.activeIndex = activeIndex
            detailVC.dataIndex = activeIndex
//            detailVC.detailView = LS_DataDetailView() // detailView or view?
            detailVC.loadData()
            detailVC.tbController = self
            detailVC.prepareView()

//            self.selectedViewController = detailVC
            
            detailVC.modalPresentationStyle = .automatic
            self.present(detailVC, animated: true, completion: nil)

//            appDelegate.window?.rootViewController?.view = detailVC.detailView
//            self.view.addSubview(detailVC.detailView) // should be self.navigationController?.pushViewController(tbController, animated: false)?
            
            break
        case 1:
            self.present(crew, animated: true, completion: nil)
            break
        case 2:
            print("media time")
//            self.parent?.present(mediaVC, animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
            
//            self.present(mediaVC, animated: true, completion: nil)
//            self.presentingViewController?.removeFromParent()
            
            media.dataIndex = self.activeIndex
            media.getPhotos()
//            media.avController = UIActivityViewController(activityItems: media.allPhotoImages, applicationActivities: nil)
            print("media.allPhotoImages.count: \(media.allPhotoImages.count)")
            print("media.allPhotoURLs.count: \(media.allPhotoURLs.count)")
            media.avController = UIActivityViewController(activityItems: ["Snow Photozz", media.getPhotoURLArray()/*media.allPhotoImages*/], applicationActivities: nil)
//            media.avController.title = "Snow Photozz"
//            media.avController.
            media.avController.excludedActivityTypes = [
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.copyToPasteboard,
            ]
            
            
            if media.avController == nil {
                print("media.avController is nil!?")
            } else {
                print("media.avController not nil...")
                // TODO: mmm, presenting media.avController gave me the view I wanted. Can I assign it to this popover?
//                if let popover = alert.popoverPresentationController {
//                    popover.barButtonItem = self.navigationItem.leftBarButtonItem
//                    popover.permittedArrowDirections = .up
//                }
                
                media.avController.modalPresentationStyle = .popover
                media.avController.popoverPresentationController?.sourceView = self.view
                
//                let navController = UINavigationController(rootViewController: media)
                
                media.modalPresentationStyle = UIModalPresentationStyle.automatic
//                media.navigationItem.setLeftBarButton(media.navigationItem.leftBarButtonItem, animated: false)
//                media.navigationItem.title = "Media View"
//                media.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(media.handleDoneButtonTapped))
//                media.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
//                media.navigationItem.setRightBarButton(media.navigationItem.rightBarButtonItem, animated: false)
//                media.setNavBar()
                
//                self.present(navController, animated: true, completion: nil)
                
//                self.present(media, animated: true, completion: nil)
                media.tbController = self
                media.dataIndex = self.activeIndex
                media.prepareMediaView()
                media.modalPresentationStyle = .automatic
                self.present(media, animated: true, completion: nil)
                
//                self.view = media.view
                
//                self.present(media/*.avController*/, animated: true, completion: nil)
            }
//            self.tabBarController?.present(mediaVC, animated: true, completion: nil)
            
//            media.viewWillAppear(true)
            
//            media.setNavBar()
//            media.view.addSubview(media.getNavBar())
//            media.viewDidLoad()

//            self.navigationController?.navigationBar.tintColor = .red
            // TODO: Need to populate allMedia and define avController before reaching this line
//            self.present(media.avController, animated: true, completion: nil)
            break
        case 3:
            self.present(share, animated: true, completion: nil)
            break
        default:
            print("Somehow tapped a button not in the range 0..3 \(item.tag)")
            break
        }
        
//        if (item.tag == 3) {
//            self.present(share, animated: true, completion: nil)
//        } else {
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        print("should select vc: \(viewController.title)")
//        print("however passed vc's restorationIdentifier: \(viewController.restorationIdentifier)")
//
//        return true
//    }
    
}


//class LS_TabBarController: UITabBarController {
//    let selectedColour = UIColor.blue
//    let deselectedColour = UIColor.gray
//
//    var tabBarImages = [UIImage(named: "beericon"),
//                        UIImage(named: "beericon"),
//                        UIImage(named: "beericon"),]
//
///*[UIImage(named: "ic_music")!,
//                        UIImage(named: "ic_play")!,
//                        UIImage(named: "ic_star")!]*/
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.frame = CGRect(x: 0.0, y: 0.0, width: super.view.frame.width, height: 20.0)
//        view.backgroundColor = UIColor.gray
//
////        self.delegate = self
//        self.tabBar.isTranslucent = true
//        self.tabBar.tintColor = deselectedColour
//        self.tabBar.unselectedItemTintColor = deselectedColour
//        self.tabBar.barTintColor = UIColor.white.withAlphaComponent(0.92)
//        self.tabBar.itemSpacing = 10.0
//        self.tabBar.itemWidth = 76.0
//        self.tabBar.itemPositioning = .centered
//
//        setup()
//
////        self.select
//    }
//
//    private func setup() {
//        guard let centerPageViewController = createCenterPageViewController() else {
//            return
//        }
//
//        var controllers: [UIViewController] = []
//
//        controllers.append(createPlaceholderViewController(forIndex: 0))
//        controllers.append(centerPageViewController)
//        controllers.append(createPlaceholderViewController(forIndex: 2))
//
//        setViewControllers(controllers, animated: false)
//
//        selectedViewController = centerPageViewController
//    }
//
//    private func selectPage(at index: Int) {
//        guard let viewController = self.viewControllers?[index] else { return }
//        self.handleTabBarItemChange(viewController: viewController)
//        guard let pageViewController = (self.viewControllers?[1] as? LS_PageViewController) else { return }
//
//        pageViewController.selectPage(at: index)
//    }
//
//    private func createPlaceholderViewController(forIndex index: Int) -> UIViewController {
//        let emptyViewController = UIViewController()
//        emptyViewController.tabBarItem = tabBarItem(at: index)
//        emptyViewController.view.tag = index
//
//        return emptyViewController
//    }
//
//    private func createCenterPageViewController() -> UIPageViewController? {
//        let leftController = ViewController()
//        let centerController = ViewController()
//        let rightController = ViewController()
//
//        leftController.view.tag = 0
//        centerController.view.tag = 1
//        rightController.view.tag = 2
//
//        leftController.view.backgroundColor = UIColor.red
//        centerController.view.backgroundColor = UIColor.green
//        rightController.view.backgroundColor = UIColor.blue
//
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//
//        guard let pageViewController = storyBoard.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController else { return nil }
//        pageViewController.tabBarItem = tabBarItem(at: 1)
//        pageViewController.view.tag = 1
////        pageViewController.swipeDelegate = self
//
//        return pageViewController
//    }
//
//    private func tabBarItem(at index: Int) -> UITabBarItem {
//        return UITabBarItem(title: nil, image: self.tabBarImages[index], selectedImage: nil)
//    }
//
//    private func handleTabBarItemChange(viewController: UIViewController) {
//        guard let viewControllers = self.viewControllers else { return }
//        let selectedIndex = viewController.view.tag
//        self.tabBar.tintColor = selectedColour
//        self.tabBar.unselectedItemTintColor = selectedColour
//
//        for i in 0 ..< viewControllers.count {
//            let tabBarItem = viewControllers[i].tabBarItem
//            let tabBarImage = self.tabBarImages[i]
//            tabBarItem?.selectedImage = tabBarImage?.withRenderingMode(.alwaysTemplate)
//            tabBarItem?.image = tabBarImage?.withRenderingMode( i == selectedIndex ? .alwaysOriginal : .alwaysTemplate)
//        }
//
//        if selectedIndex == 1 {
//            viewControllers[selectedIndex].tabBarItem.selectedImage = self.tabBarImages[1]?.withRenderingMode(.alwaysOriginal)
//        }
//    }
//
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        self.selectPage(at: viewController.view.tag)
//
//        return false
//    }
//
//    func pageDidSwipe(to index: Int) {
//        guard let viewController = self.viewControllers?[index] else { return }
//
//        self.handleTabBarItemChange(viewController: viewController)
//    }
//}
