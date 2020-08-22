//
//  ViewController.swift
//  StackViewDemo
//
//  Created by Alvy Chen on 5/9/20.
//  Copyright © 2020 Alvy Chen. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    init() {
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load TestViewController")

    }
    
    override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
        
             var items = [UIBarButtonItem]()

                       //Custom Button
                       let plainButton = UIBarButtonItem(title: "Test", style: .plain, target: self, action: nil)
                       items.append(plainButton)

                       //Add Flexible space between buttons
                   let flexibalSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                       items.append(flexibalSpace)

                       //Toolbar system button
                   let systemButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: nil)
                       items.append(systemButton)

                   if self.navigationController != nil {
                       print("NavigtionControoler is not NULL")
                   } else {
                       print("NavigationController is null")
                   }
             
             self.setToolbarItems(items, animated: true)
          //self.navigationController?.setToolbarItems(items, animated: true)
        
        if self.navigationController?.toolbarItems != nil {
                         print("NavigtionControoler toolbarItems is not NULL")
                     } else {
                         print("NavigationController toolbarItems is null")
                     }
        
        
           self.navigationController?.setToolbarHidden(false, animated: false)
        
      
         }


}

