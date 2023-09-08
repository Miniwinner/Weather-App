//
//  ViewController.swift
//  CallReminder
//
//  Created by Александр Кузьминов on 22.07.23.
//

import UIKit
import CoreLocation
//import wheatherData

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var minTemp: UILabel!
    
    @IBOutlet weak var maxTemp: UILabel!
    
    @IBOutlet weak var collectionViewWeather: UICollectionView!
   
    @IBOutlet weak var customImage: UIImageView!
    
    @IBOutlet weak var customImage2: UIImageView!
    
    @IBOutlet weak var tableViewWeather: UITableView!
    
    
    
    
    let model1 = [WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2"),WeatherSource(labelTextHour: "1", imageName: "01d", labelTextTemp: "2")]
    
    
    
    
    let locationManager = CLLocationManager()
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocationManger()
        configUI()
                
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    
    @IBAction func chooseCityLocation(_ sender: Any) {
        let alert = UIAlertController(title: "Выберите город", message: "Впишите имя города на английском", preferredStyle: .alert)
//        alert.textFields.
        let action1 = UIAlertAction(title: "Выбрать", style: .cancel){_ in
            if let textField = alert.textFields?.first, let text = textField.text{
                
                //self.getWheatherInfo(city: text)
            }
        }
        let action2 = UIAlertAction(title: "Отменить", style: .default)
        
        
        
        
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addTextField()
        self.present(alert, animated: true)
    }
    
    
    func configUI(){
//        customImage.contentMode = .scaleToFill
//        customImage.image = UIImage(named: "Untitled-3")
        customImage.alpha = 0.8
        customImage.alpha = 0.8
        displayLabel.alpha = 0.8
        tableViewWeather.delegate = self
        tableViewWeather.dataSource = self
        
        tableViewWeather.backgroundColor = .clear
        
        collectionViewWeather.delegate = self
        collectionViewWeather.dataSource = self
        collectionViewWeather.backgroundColor = .clear
        collectionViewWeather.register(
                    UINib(nibName: "WeatherCell", bundle: nil),
                    forCellWithReuseIdentifier: "indexCell")
        //collectionViewWeather.collectionViewLayout = configureLayoutForGoalsBoard()
       // collectionViewWeather.setCollectionViewLayout(configureLayoutForGoalsBoard(), animated: true)
        if let layout = collectionViewWeather.collectionViewLayout as?  UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
    }
   
    
    
    func startLocationManger(){
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
            
        }
    }
    
   
    func getWheatherInfo(latitude:Double,longtitude:Double,city:String) {

        let headers = [
            "X-RapidAPI-Key": "cb9c1f8f18msh91449e8f3edd556p1a73e3jsn7f9c3709de4b",
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://weatherapi-com.p.rapidapi.com/current.json?q=\(latitude.description)%2C\(longtitude.description)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else if let data = data{
                let httpResponse = response as? HTTPURLResponse
                do{
                    let weather:WheatherData = try! self.parseJson(type: WheatherData.self, data: data)
                    if let temperature:Int? = weather.current.tempC{
                        print(weather.current.tempC)
                        DispatchQueue.main.async {
                            self.displayLabel.text = "\(weather.current.tempC)°"
                            self.minTemp.text = "Ощущается как \(weather.current.feelslikeC)°"
                            self.maxTemp.text = weather.current.condition.text
                            
                        }
                                        }
                }catch{
                    print("Ощибка делегирования")
                }
                
            }
            
        })

        dataTask.resume()
    }
    private func parseJson<T: Decodable>(type: T.Type, data: Data) throws -> T {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        
        }
                 
    

    private func configureLayoutForGoalsBoard() -> UICollectionViewCompositionalLayout {
            let size = NSCollectionLayoutSize(
                widthDimension: .absolute(30),
                heightDimension: .absolute(30)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: size)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: item, count: 24)
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = .init(
                top: 5,
                leading: 20,
                bottom: 5,
                trailing: 0
            )
            
            return UICollectionViewCompositionalLayout(section: section)
        }
}
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if  let lastLocation = locations.last{
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(lastLocation){ placemarks,error in
                if let placemark = placemarks?.first{
                    let adress = "\(placemark.locality ?? "") \(placemark.thoroughfare ?? "")"
                    DispatchQueue.main.async {
                        self.locationLabel.text = adress
                    }
                }
            }
            getWheatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude,city: "Moscow")
            print(lastLocation.coordinate.latitude,lastLocation.coordinate.longitude)
        }
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indexCell", for: indexPath) as! WeatherCell
        
       var data = model1[indexPath.row]
        
        cell.config(model: data)
        return cell
    }
    
   }
    
    




extension ViewController:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! tableViewCell
        
        cell.tableWeather.textColor = .white

                cell.backgroundColor = .clear
        return cell
    }
    
    
}
