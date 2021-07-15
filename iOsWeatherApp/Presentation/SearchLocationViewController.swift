//
//  SearchLocationViewController.swift
//  iOsWeatherApp
//
//  Created by user on 15.07.2021.
//

import UIKit

class SearchLocationViewController: UIViewController {
    
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
        view.backgroundColor = .darkGray
        view.alpha = 0.5
        return view
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
        if let location = textField.text{
            addLocation(location: location)
        }
        let vc = WeatherPageViewController()
        print(vc.currentPageIndex)
        print(LocationManager.locationArray.count)
        vc.currentPageIndex = LocationManager.locationArray.count - 1
        print(vc.currentPageIndex)
        self.present(vc, animated: true, completion: nil)
        textField.text = ""
        return true
    }
    
}
