//
//  SearchLocationViewController.swift
//  iOsWeatherApp
//
//  Created by user on 15.07.2021.
//

import UIKit

class SearchLocationViewController: UIViewController {
    
    public var didAddLocation: (() -> ())?
    
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
    
    lazy var searchTextField : UISearchTextField = {
        let textField = UISearchTextField()
        let whitePlaceholderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = whitePlaceholderText
        textField.textAlignment = .left
        textField.layer.cornerRadius = 10
        textField.layer.backgroundColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .search
        textField.autocapitalizationType = .words
        textField.becomeFirstResponder()
        textField.autocorrectionType = .no
        return textField
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
    }
    
    
    private func configureUI() {
        view.backgroundColor = .clear
        setupHeaderView()
        setupTitleLabel()
        setupSearchTextField()
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
    
    private func setupSearchTextField(){
        headerView.addSubview(searchTextField)
        searchTextField.delegate = self
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            searchTextField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupCancelButton() {
        headerView.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            cancelButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 10)
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
// MARK: - UITextField extension

extension SearchLocationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(LocationManager.locationArray.count)
        let vc = WeatherViewController()
        if let location = textField.text{
            vc.location = location
        }
        vc.view.backgroundColor = .gray
        vc.addButton.isHidden = false
        vc.cancelButton.isHidden = false
        vc.didAddButtonPressed = { [weak self] in
            self?.didAddLocation?()
            self?.dismiss(animated: false, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
        textField.text = ""
        return true
    }
}

// MARK: - TableView extension
extension SearchLocationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
//        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = "Test test test test test test test test test"
        return cell
    }
    
    
}
