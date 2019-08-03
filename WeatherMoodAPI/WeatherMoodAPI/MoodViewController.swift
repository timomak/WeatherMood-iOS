//
//  MoodViewController.swift
//  WeatherMoodAPI
//
//  Created by timofey makhlay on 8/2/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import SnapKit
import Realm

class MoodViewController: UIViewController {
    
    var moodInputTextField: UITextView = {
        var title = UITextView()
        title.text = "Input mood..."
        title.font = UIFont(name: "AvenirNext-Bold", size: UIScreen.main.bounds.height / 20) // Size to make it scalable (supposed to be around 33 onn iphone x)
        title.textColor = #colorLiteral(red: 0.0774943307, green: 0.1429743171, blue: 0.290320158, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = true
        title.isScrollEnabled = false
        title.isSelectable = true
        return title
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        
        view.addSubview(moodInputTextField)
        
        moodInputTextField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
    }
    
    @objc func saveTapped(sender: UIBarButtonItem) {
        print("Saving")
        self.navigationController?.popViewController(animated: true)
    }
}
