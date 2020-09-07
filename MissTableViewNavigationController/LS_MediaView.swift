//
//  LS_MediaView.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 4/2/20.
//  Copyright © 2020 Loose Star. All rights reserved.
//

import UIKit

//protocol LS_BackButtonMediaDelegate {
//    func onBackButtonTouched(sender: UIButton)
//}

// TODO: MediaView should ba en ActionSheet if in picker mode
class LS_MediaView: UIView {
    var delegate: LS_BackButtonDelegate?
    /*@IBOutlet*/ var mvImage: UIImage!
    var imageView: UIImageView!
    var button = UIButton()
    
    override var description: String {
        return("mvImage: \(mvImage.debugDescription)\nimageView: \(imageView.image.debugDescription)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.safeAreaLayoutGuide
//        self.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
//        self.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.0).isActive = true
        self.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0.0).isActive = true
        self.topAnchor.constraint(equalTo: guide.topAnchor, constant: 56.0).isActive = true // was a constant of 0.
        
        if (self.mvImage == nil) && (self.imageView == nil) {
            print("mvImage and imageView are nil...ick! (should show image picker, also have to initialise mediaView at mediaViewController)")
            
            // need to add an instance of LS_ImagePicker here !*#$
//            self.setImagePicker()
        } else {
//            imageView = UIImageView(image: mvImage)
//            imageView.frame = CGRect(x: 0.0, y: 0.0, width: mvImage.size.width, height: mvImage.size.height)
            print("setMediaView with known image")
            self.setMediaView()
            
//            imageView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
//            imageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
//            imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
//            imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        }
    }
    
    
//    func setImagePicker() {
//
//    }
    
    
    func setMediaView() {
//        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 44))
//        let naviagtionBar: UINavigationBar = UINavigationBar(frame: CGRect.zero)
//        naviagtionBar.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(naviagtionBar)
        
//        let navigationItem = UINavigationItem(title: "DetailView (Media)")
// -- back button?        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(handleDoneButtonTapped))
//        navigationItem.rightBarButtonItem = doneButton
//        navigationItem.leftBarButtonItem = _editButtonItem
        
//        naviagtionBar.setItems([navigationItem], animated: false)
        
        self.imageView = UIImageView(image: self.mvImage)
        
        let mediaViewTest: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width/2, height: self.frame.height/2))
        let margins = self.layoutMarginsGuide
        let guide = self.safeAreaLayoutGuide
        let viewWidth = self.frame.width
        let viewHeight = self.frame.height
//        self.addSubview(mediaViewTest)
        
        self.addSubview(mediaViewTest)
        mediaViewTest.translatesAutoresizingMaskIntoConstraints = false
        mediaViewTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mediaViewTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        mediaViewTest.backgroundColor = UIColor.black
//        mediaViewTest.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        mediaViewTest.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        mediaViewTest.topAnchor.constraint(equalTo: guide.topAnchor, constant: 56.0).isActive = true
//        mediaViewTest.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        mediaViewTest.backgroundColor = UIColor.black
//        mediaViewTest.addSubview(imageView)
//        mediaViewTest.translatesAutoresizingMaskIntoConstraints = false
//        mediaViewTest.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
//        mediaViewTest.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true

////        mediaViewTest.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        mediaViewTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        mediaViewTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        mediaViewTest.backgroundColor = UIColor.black
//        mediaViewTest.topAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0.0).isActive = true
//        mediaViewTest.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0.0).isActive = true
//        mediaViewTest.addSubview(imageView)
        
        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
////        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
////        imageView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
////        imageView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
//        imageView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
////        imageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true      //--
//        imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
////        imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true  //--
//        imageView.backgroundColor = UIColor.black
        
//        mediaViewTest.translatesAutoresizingMaskIntoConstraints = false // WAS ABOVE addSubview
//        mediaViewTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        mediaViewTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        mediaViewTest.widthAnchor.constraint(equalToConstant: viewWidth/2.0).isActive = true
//        mediaViewTest.heightAnchor.constraint(equalToConstant: viewHeight/2.0).isActive = true
//        mediaViewTest.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 56.0).isActive = true // TODO: Calculate this constant instead of use a magic number
//        mediaViewTest.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true      //--
//        mediaViewTest.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
//        mediaViewTest.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true  //--
        
        mediaViewTest.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false // WAS ABOVE addSubview
        
        imageView.centerXAnchor.constraint(equalTo: mediaViewTest.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: viewWidth/2.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewHeight/2.0).isActive = true
        imageView.topAnchor.constraint(equalTo: mediaViewTest.topAnchor).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true      //--
//        imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true  //--
        imageView.backgroundColor = UIColor.clear
    }
    
    func onBackButtonTouched(sender: UIButton) {
        // invoke the delegate when the button is touched
        delegate?.onBackButtonTouched(sender: sender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
