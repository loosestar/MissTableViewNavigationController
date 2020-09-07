//
//  LS_ImagePicker.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 3/2/20.
//  Copyright © 2020 Loose Star. All rights reserved.
//

import UIKit

public protocol LS_ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

open class LS_ImagePicker: NSObject {
    private var pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: LS_ImagePickerDelegate?
    
    private var imageView: UIImageView?
    /*private*/ var mediaViewController: LS_MediaViewController?
    
    public init(presentationController: UIViewController, delegate: LS_ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
//        self.mediaViewController = LS_MediaViewController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.sourceType = .savedPhotosAlbum
        self.pickerController.mediaTypes = ["public.image"]
        
        self.imageView = UIImageView()
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    public func getController() -> UIImagePickerController {
        if (self.pickerController == nil) {
            self.pickerController = UIImagePickerController()
            self.pickerController.delegate = self
            self.pickerController.allowsEditing = false
        }
        return self.pickerController
    }
    
//    public func getDelegate() -> LS_ImagePickerDelegate {
//        return self.delegate!
//    }
    
    // this needs a bit of error cehcking around it!
    func getChosenMediaController() -> LS_MediaViewController {
        return self.mediaViewController!
    }
    
    public func setDelegate(delegate: LS_ImagePickerDelegate) {
        self.delegate = delegate
    }
    
    func setMediaViewController(mediaViewController: LS_MediaViewController) {
        // TODO: should verify the mediaViewController being assigned exists
        self.mediaViewController = mediaViewController
    }
    
    public func getImage() -> UIImage {
        if self.imageView?.image != nil {
            return (self.imageView?.image)!
        } else {
            print("self.imageView?.image is nil")
            return UIImage(named: "Snow")!
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {        
        imageView?.image = image
        
        print("pickerController LS_ImagePicker")
        
        self.delegate?.didSelect(image: image)
    }
    
    func pickedImage() -> UIImageView {
        return imageView!
    }
}

extension LS_ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled!")
        self.pickerController(picker, didSelect: nil)
        self.presentationController?.dismiss(animated: true, completion: nil)
        self.pickerController.setNavigationBarHidden(false, animated: true) // hmm
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.mediaViewController?.setNavBar()
        
        self.pickerController.dismiss(animated: true, completion: nil)
        self.pickerController.setNavigationBarHidden(false, animated: true) // hmm
        
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
//            self.pickerController.dismiss(animated: true, completion: nil)
            print("not chosen(?)")
            return
        }
        
//        self.pickerController.dismiss(animated: true, completion: nil)
        print("chosen!")
        print("chosen info \(info)")
        
        self.mediaViewController?.tabBarController?.selectedIndex = 0
        
        // self.mediaViewController?.view.setNeedsDisplay (?)
//        mediaViewController?.imageView.contentMode = .scaleAspectFit
        
        // TODO: this instance of mediaViewController needs to be the same as that of the LS_MediaViewController which created this instance of LS_ImagePicker
        if (chosenImage != nil) {
            // hmmmmm?
            self.imageView?.image = chosenImage
            
            print("chosenImage about to be displayed")
            // update title string
//            self.mediaViewController?.navigationItem.title = "DetailView (Media)"
            
            self.mediaViewController?.mvImage = chosenImage
            
//            self.mediaViewController?.mediaView = LS_MediaView()
            // TODO: should be a MediaViewController method?
//            self.mediaViewController?.mediaView.imageView = UIImageView()
            print("self.mediaViewController?.mvImage: \(self.mediaViewController?.mvImage)")
            self.mediaViewController?.mediaView.imageView.image = self.mediaViewController?.mvImage
            
            self.mediaViewController?.mediaView.mvImage = self.mediaViewController?.mvImage
            
            self.pickerController.dismiss(animated: true, completion: {
                () -> Void in
            })

//            self.mediaViewController?.mediaView.setMediaView()
            self.mediaViewController?.mediaView.setNeedsDisplay()
        }
        
//        mediaViewController?.imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: chosenImage.size))
//        mediaViewController?.imageView.image = chosenImage
        
//        self.mediaViewController?.prepareView()
        
//        if self.mediaViewController?.mediaView != nil {
//            self.mediaViewController?.mediaView.setMediaView()
//            
//            self.mediaViewController?.mediaView.setNeedsDisplay()
//        } else {
//            print("WARNING: current mediaViewController's mediaView is nil")
//            
//            self.mediaViewController?.mediaView = LS_MediaView()
//            self.mediaViewController?.mvImage = chosenImage
//            self.mediaViewController?.mediaView.setMediaView()
//            
//            self.mediaViewController?.mediaView.setNeedsDisplay()
//        }
//        self.mediaViewController?.view.layoutIfNeeded()
//        self.presentationController?.present(mediaViewController!, animated: false, completion: nil)
//        self.pickerController(picker, didSelect: chosenImage)
        
//        return
        
//        delegate?.didSelect(image: chosenImage)
//        self.pickerController(picker, didSelect: chosenImage)
        
//        picker.dismiss(animated: true, completion: nil)
        
//        mediaViewController?.imageView.image = chosenImage
//        presentationController?.present(mediaViewController!, animated: true, completion: nil)
        
//        self.presentationController?.present(mediaViewController!, animated: false, completion: nil)//(self.getController(), animated: false, completion: nil)
        
//        self.pickerController.present(mediaViewController!, animated: true, completion: nil)
        
//        imageView?.image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
//        imageView?.contentMode = UIView.ContentMode.scaleAspectFit
//
//        mediaViewController?.imageView = imageView
        // TODO: tempImage should be a more obvious placeholder defined at init of mediaView
//        mediaViewController?.mediaView = LS_MediaView()
//        HMMMM...mediaViewController?.currentMedia = LS_Media(type: <#T##String#>, name: <#T##String#>)
//        self.presentationController?.present(mediaViewController!, animated: true, completion: nil)
        
        
        
//        self.dismiss(animated: true, completion: nil)
        
//        self.pickerController.dismiss(animated: true, completion: nil)
        
//        guard let image = info[.originalImage] as? UIImage else {
//            print("expected a dictionary containing an image, but received: \(info)")
//            return self.pickerController(picker, didSelect: nil)
//        }
//
//        self.mediaViewController?.view.removeFromSuperview()
//
//        self.mediaViewController?.mediaView = LS_MediaView()
//
//        self.presentationController?.present(self.mediaViewController!, animated: true)
////        mediaViewController?.mediaView.tempImage = image
//
////        self.mediaViewController?.view.addSubview(self.mediaViewController!.mediaView)
//        self.pickerController(picker, didSelect: image)
//
//        print("image: \(image.accessibilityValue)")
//
//        self.pickerController.dismiss(animated: true, completion: nil)
//
//        self.presentationController?.present((self.mediaViewController?.getSelectedMediaViewController())!, animated: true)
        
//        self.pickerController(picker, didSelect: image)
        
        // should check if mediaViewController is legitimate, and contains an image
//        self.presentationController?.present(mediaViewController!, animated: true, completion: nil)
        
        
        // TODO: segue or present an image/mediaView here?
    }
}

extension LS_ImagePicker: UINavigationControllerDelegate {
    
}
