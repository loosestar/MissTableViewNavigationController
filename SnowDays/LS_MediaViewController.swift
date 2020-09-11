//
//  LS_MediaViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 3/2/20.
//  Copyright © 2020 Loose Star. All rights reserved.
//

import UIKit
import Photos

//protocol LS_MediaProtocol {
//    var media: LS_Media {get set}
//}

class LS_MediaViewController: UIViewController, UIActivityItemSource, UINavigationControllerDelegate, /*UIImagePickerControllerDelegate*/LS_ImagePickerDelegate, LS_BackButtonDelegate {
    func onBackButtonTouched(sender: UIButton) {
        print("back button touched")
    }
    
    @IBOutlet var imageView: UIImageView!
    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var mediaView: LS_MediaView! = nil
    
    var allMedia: [LS_Media]?
    var allPhotos: PHFetchResult<PHAsset>? = nil
    var allPhotoImages = [UIImage]()
    var allPhotoURLs: [URL] = [URL]()   //? = nil
    var currentMedia: LS_Media!
    var currentData: LS_Data!
    var imageAssets = [PHAsset]()
    var mvImage: UIImage! = nil
    var dataIndex: Int!
    
    var avController: UIActivityViewController!
    
    var imagePicker: LS_ImagePicker!
    let mediaSheetController: UIAlertController = UIAlertController(title: "Media!", message: "Do the thing", preferredStyle: .actionSheet)
    
    var tbController: LS_TabBarController! // = LS_TabBarController()
    
    
    fileprivate lazy var _navigationBar: UINavigationBar = UINavigationBar(frame: CGRect.zero)
    fileprivate lazy var _shareButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "SquareArrowUp"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.handleShareButtonTapped))
    }()
    fileprivate lazy var _doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(handleDoneButtonTapped))
    
    // add a navbar
    override func viewWillLayoutSubviews() {
        let width = self.view.frame.width
        let height = self.view.frame.height - 44.0 // must subtract navbar height which should be a konstant
//        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44))
//        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect.zero)
//        self.view.addSubview(_navigationBar)
        
        let navigationItem = UINavigationItem(title: "MediaView")
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(handleDoneButtonTapped))
        navigationItem.leftBarButtonItem = _shareButtonItem
        navigationItem.rightBarButtonItem = doneButton
        
        _navigationBar.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        _navigationBar.setItems([navigationItem], animated: false)
        self.view.addSubview(_navigationBar)
        
        self.view.setNeedsLayout()
        
//        tbController.view.frame = CGRect(x: 0.0, y: height - 44, width: width, height: 44)
//        tbController.view.isUserInteractionEnabled = true
//        tbController.activeIndex = dataIndex
//        self.view.addSubview(tbController.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("M[edia]VC")
                
        self.setNavBar()
//        self.setNeedsStatusBarAppearanceUpdate()
        
//        self.imageView = UIImageView()
        imageView = UIImageView()
        self.mediaView = LS_MediaView()
        self.mediaView.delegate = self
        
        self.preparePicker()
        self.prepareMediaView()
        self.mediaView.setMediaView()
        
        self.getMediaResources()
        self.getPhotos()
//        self.avController = UIActivityViewController(activityItems: allPhotoImages, applicationActivities: nil)
        
        print("mediaVC")
//        self.navigationController?.present(self, animated: true, completion: nil)
        self.view = self.mediaView // mediaView should be a subview, which should in turn be positioned with auto layout
    }
    
    
//    override func willMove(toParent parent: UIViewController?) {
//        self.navigationController?.addChild(_navigationBar)
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        self.setNavBar()
//        self.setNeedsStatusBarAppearanceUpdate()
        // Doesn't seem to be updating...hmm
        
        if mediaView.mvImage == nil {
            print("mvImage is nil")
//            self.prepareMediaView()
        //            self.mediaView = LS_MediaView() // ALREADY DECLARED
            
            // TODO: initialise here for future testing
//            OLD: mediaView.mvImage = imageView.image
//            self.prepareMediaView()
            
                // configure image picker
//            self.view.window?.rootViewController?.present(imagePicker.getController(), animated: false, completion: nil)
//            self.preparePicker()
            
            self/*.navigationController?*/.present(imagePicker.getController(), animated: false, completion: {
//            self.present(self.avController, animated: false, completion: {
//            self.present(imagePicker.getController(), animated: false, completion: { // TESTING
//                self.didSelect(image: self.imagePicker.getImage()) // IS THIS LINE REACHED? WHAT HAPPENS AFTER IT?
                print("yay?")
                // hmmmmmm?
                //---- testing --------
                self.mediaView.delegate = self
//                self.mediaView.mvImage = self.imagePicker.getImage()
                self.mediaView.setMediaView()
                //---- end testing ----
//                self.view = self.mediaView // TODO: Should be a subview! Positioned between the bottom of the navbar and top of tabbar
                self.view.setNeedsDisplay()
                
//                self.setNavBar()
                self.setNeedsStatusBarAppearanceUpdate()
                // Doesn't seem to be updating...hmm
//                self.view.addSubview(self.mediaView)
            })// -- works? Autolayout stuffup?

//            self.mediaView.mvImage = self.imagePicker.getImage()
//            self.view = self.mediaView
            
//          self.view.addSubview(<#T##view: UIView##UIView#>)
//          self.present(mediaSheetController, animated: true, completion: nil)
                
        //            mediaView.setMediaView()
        //            self.view = mediaView
                
        //            self.view.layoutSubviews()
        //            self.view.layoutIfNeeded()
                
        //            mediaView.setMediaView()
        //            self.view = mediaView
                
        //            self.present(imagePicker.getController(), animated: false, completion: nil)
        } else {
        //            self.mediaView.setNeedsDisplay()
        //            self.mediaView.tempImage = self.imageView.image
                
                // TODO: this screams hack. can it be done in imagePicker?
        //            mediaView.delegate = self as! LS_BackButtonDelegate
            print("setting chosen media")
            print("mediaView.description: \(self.mediaView.description)")
            
//            self.navigationController?.navigationBar.isUserInteractionEnabled = true
//            self.navigationController?.tabBarController?.tabBar.isUserInteractionEnabled = true
            
//            self.present(imagePicker.getChosenMediaController(), animated: false, completion: {
//            self.view = self.mediaView
            self.view.setNeedsDisplay()
//            })
            
//            mediaView.setMediaView()
//            self.view = mediaView
//            self.view.setNeedsDisplay()
                
        //            self.present(getSelectedMediaViewController()!, animated: true, completion: nil)
        //            self.present(imagePicker.pickedImageView(), animated: true, completion: nil)
        }
    }
    
    
    func getMediaResources() {
        let status = PHPhotoLibrary.authorizationStatus()
        let alert = UIAlertController(title: "Media", message: "Get media?", preferredStyle: UIAlertController.Style.alert)
        
        if (status == .denied || status == .restricted) {
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            PHPhotoLibrary.requestAuthorization({ (authStatus) in
                if authStatus == .authorized {
                    let imageAsset = PHAsset.fetchAssets(with: .image, options: nil)
                    
                    for i in 0..<imageAsset.count {
                        self.imageAssets.append((imageAsset[i]))
                    }
                }
            })
        }
    }
    
    
    /*fileprivate*/ func getPhotos() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat // for high quality photos, obviously -- maybe turn off if too much data, or provide an option?
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
//        group.enter()
        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        let group = DispatchGroup()

        print("PHFetchResults.count: \(results.count)")
        
        if results.count > 0 {
            for i in 0..<results.count {
                group.enter()
                print("result[\(i)]")
                let asset = results.object(at: i)
                let size = CGSize(width: 700, height: 700)
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: requestOptions, resultHandler: { (image, _) in
                    if let image = image {
                        group.enter()
                        print("appending image \(i)")
                        self.allPhotoImages.append(image)
                        // reloading view here
                    } else {
                        print("error converting asset to UIImage")
                    }
                    
                    group.leave()
                })

                
                asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions(), completionHandler: { (input, _) in
                    if let url = input?.fullSizeImageURL {
                        group.enter()
                        print("appending url \(i)")
                        self.allPhotoURLs.append(url)
                    } else {
                        print("error finding asset's URL")
                    }
                    
                    group.leave()
                })
            }
            
            print("allPhotoImages.count: \(self.allPhotoImages.count)")
            print("allPhotoURLs.count: \(self.allPhotoURLs.count)")
        } else {
            print("no photos to display")
        }
        
        group.leave()
        
        group.notify(queue: .main, execute: {
            print("allPhotosURLs: \(self.allPhotoURLs.count)")
            print("allPhotoImages: \(self.allPhotoImages.count)")
        })
    }
    
    
    func preparePicker() {
        if (self.imagePicker == nil) {
            self.imagePicker = LS_ImagePicker(presentationController: self, delegate: self)
            self.imagePicker.setDelegate(delegate: self) //.setDelegate(delegate: self)
            self.imagePicker.getController().allowsEditing = false
            
            self.imagePicker.setMediaViewController(mediaViewController: self)
        } else {
            print("imagePicker already prepared")
        }
    }
    
    
    func prepareMediaView() {
        self.navigationItem.title = "MediaView"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handleDoneButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        
        if mvImage != nil {
            print("Preparing mediaView for drawification")
            mediaView.mvImage = mvImage
            mediaView.imageView = UIImageView(image: mvImage)
        } else {
            print("WARNING: mvImage is nil in LS_MediaViewController")
            // TODO: Show a placeholder here?
            mediaView = LS_MediaView()
//            mediaView.mvImage = UIImage(named: "Snow")
//            mediaView.imageView = UIImageView(image: mediaView.mvImage)
        }
    }
    
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
//        return UIImage(named: "Snow") ?? "Snow icon"
        return UIImage(named: "beericon") ?? "Beer icon"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
//        return UIImage(named: "Snow") ?? "Snow icon"
        return UIImage(named: "beericon") ?? "Beer icon"
    }
    
    func prepareView() {
        if (self.mediaView != nil) {
            if (self.dataIndex != -1) {
//                self.view.addSubview(self.mediaView)
                self.view = self.mediaView
            }
        } else {
//            self.imageView = UIImageView()
//            self.mediaView = LS_MediaView() NO! You've already declared mediaView
            self.prepareMediaView()
            self.mediaView.setMediaView()
            // other variable defined elsewhere
        }
    }
    
    @objc func handleDoneButtonTapped() {
        print("done!")
        // should be going back to the detailview
        
//        let navController = UINavigationController(rootViewController: self)
//        UIApplication.shared.windows.first?.rootViewController = navigationController
//
//        self.dismiss(animated: false, completion: nil)
        
        let destinationDetailViewController = LS_DataDetailViewController()
        destinationDetailViewController.dataIndex = self.dataIndex
        destinationDetailViewController.loadData()
        destinationDetailViewController.tbController = self.tbController
//        destinationDetailViewController.loadData()
        
//        if destinationDetailViewController.tbController.modelController != nil {
//            destinationDetailViewController.modelController = destinationDetailViewController.tbController.modelController
//        }
        
        self.present(destinationDetailViewController, animated: false, completion: nil)
    }
    
    
    @objc func handleShareButtonTapped() {
        print("share! (the image)")
        
        
    }
    
    func getShareButton() -> UIBarButtonItem {
        return self._shareButtonItem
    }
    
    
//    func selectTabBarItemWithIndex(value: Int) {
//        self.tbController.selectedIndex = 0
//        self.tbController.tabBar(self.tbController.tabBar, didSelect: (self.tbController.tabBar.items!)[value])
//    }
    
    
    func getNavBar() -> UINavigationBar {
        print("get media navBar")
        
        return self._navigationBar
    }
    
    func getPhotoURLArray() -> [URL] {
        print("get photo URL array with count: \(self.allPhotoURLs.count)")
        
        return self.allPhotoURLs
    }
    
    
    func setNavBar() {
        let navigationItem = UINavigationItem(title: "MediaView")
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(handleDoneButtonTapped))
        navigationItem.leftBarButtonItem = _shareButtonItem
        navigationItem.rightBarButtonItem = doneButton
        
        _navigationBar.setItems([navigationItem], animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
       
        print("Media navBar set")
    }
    
    
    func getSelectedMediaViewController() -> UIViewController? {
        let selectedMediaViewController = LS_MediaViewController()
        selectedMediaViewController.currentMedia = self.currentMedia
        
        return selectedMediaViewController
    }

    // TODO: Should be in an extension! (?)
    func didSelect(image: UIImage?) {
        print("didSelect?")
        
        if image != nil {
            print("selecting image in delegate method")
            self.imageView.image = image
            self.mediaView.mvImage = image
            self.mediaView.imageView.image = image
        } else {
            print("WARNING: image selected is nil")
            // display default mediaView with default image
        }
    }
}

//extension LS_MediaViewController: LS_ImagePickerDelegate {
//    func didSelect(image: UIImage?) {
//        if image != nil {
//            print("selecting image in delegate method")
//            self.imageView.image = image
//            self.mediaView.mvImage = image
//        } else {
//            print("WARNING: image selected is nil")
//        }
//    }
//}
