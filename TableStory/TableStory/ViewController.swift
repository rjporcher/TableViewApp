//
//  ViewController.swift
//  TableStory
//
//  Created by Porcher, RJ on 3/17/25.
//

import UIKit
import MapKit


let data = [
    Item(name: "Lamborghini Huracan", neighborhood: "Lego Stroe", desc: "Green and black Lego Technic Lamborghini Huracan. If you are looking to start a car collection but on a buget, the lego huracan is just for you. A stable in the super can community.", lat: 30.257811, long: -97.807068, imageName: "lambo"),
    Item(name: "Mona Lisa", neighborhood: "Lego Store", desc: "Lego Icons Mona Lisa Wall Art. One of the most iconic paintings created now can be built by hand. Now people at home can feel like Leonardo da Vinci.", lat: 30.257811, long: -97.807068, imageName: "monalisa"),
    Item(name: "Over the Moon", neighborhood: "Lego Store", desc: "Lego Icons Over The Moon with Pharrell Williams. One of the most iconic producers and fashion minds in the business. Pharrell adds a lego set to his name. This came out when his lego movie came out in 2024.", lat: 30.257811, long: -97.807068, imageName: "rocket"),
    Item(name: "Spider-Man", neighborhood: "Store", desc: "Lego Marvel Spider-Man Helmet. Spider-man has many lego sets this one is no different. If you want a hero get spider-man, but if you want a villian Venom also has a mask helmet for you to build. ", lat: 30.257811, long: -97.807068, imageName: "spiderman"),
    Item(name: "The Mandalorian", neighborhood: "Lego Store", desc: "Lego Starwars Mandalorian Helmet. This allows people to create a character from the beloved series and can collecte many more from star wars.", lat: 30.257811, long: -97.807068, imageName: "starwars")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        //Add image references
                     let image = UIImage(named: item.imageName)
                     cell?.imageView?.image = image
                     cell?.imageView?.layer.cornerRadius = 10
                     cell?.imageView?.layer.borderWidth = 5
                     cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
      
    }

    
    
    
    
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
    let coordinate = CLLocationCoordinate2D(latitude: 30.257811, longitude: -97.807068)
    let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
              mapView.setRegion(region, animated: true)
              
           // loop through the items in the dataset and place them on the map
    for item in data {
                  let annotation = MKPointAnnotation()
                  let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                  annotation.coordinate = eachCoordinate
                      annotation.title = item.name
                      mapView.addAnnotation(annotation)
                      }


    }


}

