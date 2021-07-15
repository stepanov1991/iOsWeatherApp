//
//  LocationsViewController.swift
//  iOsWeatherApp
//
//  Created by user on 14.07.2021.
//

import UIKit

class LocationsViewController: UIViewController {
    
    public var didSelectPage: ((Int) -> ())?
    
    lazy var locationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LocationVCCell.self, forCellReuseIdentifier: "LocationVCCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var searchLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(searchLocationButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    var tableViewHeightConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTableViewHeight()
    }
    
    func updateTableViewHeight() {
        tableViewHeightConstraint.constant = CGFloat(LocationManager.locationArray.count * 60)
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        setupLocationTableView()
        setupSearchLocationButton()
    }
    
    private func setupLocationTableView() {
        view.addSubview(locationTableView)
        locationTableView.backgroundColor = .black
        locationTableView.delegate = self
        locationTableView.dataSource = self
        tableViewHeightConstraint =  locationTableView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            locationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewHeightConstraint
        ])
    }
    
    private func setupSearchLocationButton() {
        view.addSubview(searchLocationButton)
        NSLayoutConstraint.activate([
            searchLocationButton.topAnchor.constraint(equalTo: locationTableView.bottomAnchor, constant: 10),
            searchLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchLocationButton.widthAnchor.constraint(equalToConstant: 20),
            searchLocationButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func remove(location:String) {
        LocationManager.remove(location: location)
    }
    
    @objc private func searchLocationButtonPressed() {
        let vc = SearchLocationViewController()
        vc.didAddLocation = { [weak self] in
            self?.locationTableView.reloadData()
            self?.updateTableViewHeight()
        }
        self.present(vc, animated: true, completion: nil)
    }
    

}

// MARK: - TableView extension
extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationManager.locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationVCCell", for: indexPath) as! LocationVCCell
        cell.location = LocationManager.locationArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = LocationManager.locationArray[indexPath.row]
            remove(location: location)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateTableViewHeight()
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectPage?(indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
