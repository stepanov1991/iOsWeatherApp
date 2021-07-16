//
//  SearchLocationViewController.swift
//  iOsWeatherApp
//
//  Created by user on 15.07.2021.
//

import UIKit
import MapKit

class SearchLocationViewController: UIViewController {
    
    public var didAddLocation: (() -> ())?
    var searchResults = [MKLocalSearchCompletion]()
    var searchCompleter = MKLocalSearchCompleter()
    
    lazy var headerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Enter city"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        searchBar.layer.backgroundColor = UIColor.lightGray.cgColor
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.returnKeyType = .search
        searchBar.autocapitalizationType = .words
        searchBar.becomeFirstResponder()
        searchBar.autocorrectionType = .no
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(cancelButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.8
        return view
    }()
    
    lazy var searchResultsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        searchCompleter.delegate = self
    }
    
    
    private func configureUI() {
        view.backgroundColor = .clear
        setupHeaderView()
        setupTitleLabel()
        setupSearchBar()
        setupCancelButton()
        setupBottomView()
        setupSearchResultsTableView()
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
        ])
    }
    
    private func setupSearchBar(){
        headerView.addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupCancelButton() {
        headerView.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            cancelButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            cancelButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 10)
        ])
    }
    
    private func setupBottomView() {
        view.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupSearchResultsTableView() {
        bottomView.addSubview(searchResultsTableView)
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
        ])
    }
    
    @objc private func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addLocation(location:String) {
        LocationManager.add(location: location)
    }
}
// MARK: - MKLocalSearchCompleter extension
extension SearchLocationViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
// MARK: - UISearchBar extension
extension SearchLocationViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}
// MARK: - TableView extension
extension SearchLocationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        let searchResult = searchResults[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let location = response?.mapItems[0].name else { return }
            let vc = WeatherViewController()
            vc.location = location
            vc.view.backgroundColor = .gray
            vc.addButton.isHidden = false
            vc.cancelButton.isHidden = false
            vc.didAddButtonPressed = { [weak self] in
                self?.didAddLocation?()
                self?.dismiss(animated: false, completion: nil)
            }
            self.present(vc, animated: true, completion: nil)
        }
    }
}
