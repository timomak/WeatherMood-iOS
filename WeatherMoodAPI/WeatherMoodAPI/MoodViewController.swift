//
//  MoodViewController.swift
//  WeatherMoodAPI
//
//  Created by timofey makhlay on 8/2/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import Alamofire

class MoodViewController: UIViewController {
    var temp = 0.0
    
    let urlString = "https://api.openweathermap.org/data/2.5/weather?"
    let APIKey = "4224d38642aacc879083d8580389f0db"
    
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
        getWeatherData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        
        view.addSubview(moodInputTextField)
        
        moodInputTextField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
    }
    
    @objc func saveTapped(sender: UIBarButtonItem) {
        print("Saving")
        let realmFunc = RealmFunc()
        realmFunc.write(mood: moodInputTextField.text!, temp: temp)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getWeatherData() {
        
        DispatchQueue.main.async {
            // format: http://api.openweathermap.org/data/2.5/weather?lat=42.365486&lon=71.103802&APPID=yourAPIKey
            Alamofire.request(self.urlString + "lat=\(42.365486)" + "&lon=\(71.103802)" + "&units=imperial" + "&APPID=\(self.APIKey)", method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                        
                    case .success(let JSON):
                        let main = JSON as! NSDictionary
                        self.temp = (main["main"] as! [String: Any])["temp"]! as! Double
                        print("response:\n", self.temp)
                        
                        
                    case .failure(let error):
                        print("Sensor Failiure:",error)
                    }
            }
        }
    }
}


class Mood: Object {
    @objc dynamic var mood = ""
    @objc dynamic var temp = 0.0
}


class RealmFunc {
    let realm = try! Realm()
    
    
    func write(mood:String, temp:Double) {
        let obj = Mood()
        obj.mood = mood
        obj.temp = temp
        try! realm.write {
            realm.add(obj)
        }
    }
    
    func read() {
        var objects = realm.objects(Mood.self)
        print("Person saved in realm: ", objects)
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
