//
//  LocationsViewController.swift
//  iOsWeatherApp
//
//  Created by user on 14.07.2021.
//

import UIKit

class LocationsViewController: UIViewController {
    
    lazy var locationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LocationVCCell.self, forCellReuseIdentifier: "LocationVCCell")
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        setupLocationTableView()

    }
    private func setupLocationTableView() {
        view.addSubview(locationTableView)
        locationTableView.backgroundColor = .black
        locationTableView.delegate = self
        locationTableView.dataSource = self
        NSLayoutConstraint.activate([
            locationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    /// this should be inside the delete button callback
    private func remove(location:String) {
        // let location = LocationManager.locationArray[indexPath.row]
        LocationManager.remove(location: location)
    }
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationManager.locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationVCCell", for: indexPath) as! LocationVCCell
        cell.location = LocationManager.locationArray[indexPath.row]
        return cell
    }
}
