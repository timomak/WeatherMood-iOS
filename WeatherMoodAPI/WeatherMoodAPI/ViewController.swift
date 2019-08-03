//
//  ViewController.swift
//  WeatherMoodAPI
//
//  Created by timofey makhlay on 8/2/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import Alamofire
import Realm

//class ViewController: UIViewController {
//
//    let urlString = "https://api.openweathermap.org/data/2.5/weather?"
//    let APIKey = "4224d38642aacc879083d8580389f0db"
//
//    // TODO: Get the user's actual location: https://stackoverflow.com/questions/25296691/get-users-current-location-coordinates
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//        getWeatherData()
//
//
//    }
//
//    func getWeatherData(){
//        DispatchQueue.main.async {
//            // format: http://api.openweathermap.org/data/2.5/weather?lat=42.365486&lon=71.103802&APPID=yourAPIKey
//            Alamofire.request(self.urlString + "lat=\(42.365486)" + "&lon=\(71.103802)" + "&units=imperial" + "&APPID=\(self.APIKey)", method: .get, encoding: JSONEncoding.default)
//                .responseJSON { response in
//                    switch response.result {
//
//                    case .success(let JSON):
//                        let main = JSON as! NSDictionary
//                        let temp = (main["main"] as! [String: Any])["temp"]!
//                        print("response:\n", temp)
//
//
//                    case .failure(let error):
//                        print("Sensor Failiure:",error)
//                    }
//            }
//        }
//    }
//}


class ViewController: UITableViewController {
    
    let cellId = "cellId"

    let dataForTableView = ["Number"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Records"
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(addTapped))

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        print("New VC")
        let moodVC = MoodViewController()
        self.navigationController?.pushViewController(moodVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        //        let name = indexPath.section == 0 ? names[indexPath.row] : cNames[indexPath.row]
        let name = dataForTableView[indexPath.row]
        cell.textLabel?.text = name

//        // Adding an image
//        var image : UIImage = #imageLiteral(resourceName: "Screen Shot 2018-11-08 at 1.04.35 PM")
//        cell.imageView?.image = image


        // Standard options for accessories
//        cell.accessoryType = UITableViewCell.AccessoryType.checkmark
//        cell.accessoryView?.backgroundColor = UIColor.blue
        return cell
    }

}

