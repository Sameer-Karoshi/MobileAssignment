//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//


import UIKit

class ContentViewController: UIViewController, UISearchResultsUpdating {
    
    
    private let viewModel = ContentViewModel()
    private var devices: [DeviceData] = []
    private var filteredDevices: [DeviceData] = []
    private var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    private let searchViewController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // searchViewController
        searchViewController.searchResultsUpdater = self
        searchViewController.obscuresBackgroundDuringPresentation = false
        searchViewController.searchBar.placeholder = "Search for devices"
        navigationItem.searchController = searchViewController
        definesPresentationContext = true
    
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DeviceCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        fetchData()
        
        navigationItem.title = "Computers"
        view.backgroundColor = .white
    }
    
    func fetchData() {
        activityIndicator.startAnimating()

        Task {
            await ContentViewModel().fetchAPI { data in
                self.devices = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
        self.activityIndicator.stopAnimating()
        self.tableView.isHidden = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            filteredDevices = devices
            tableView.reloadData()
            return
        }
        
        filteredDevices = devices.filter{$0.name.lowercased().contains(query.lowercased())}
        tableView.reloadData()
    }
}

extension ContentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath)
        var device = devices[indexPath.row]
        if filteredDevices.count > 0, indexPath.row < filteredDevices.count {
            device = filteredDevices[indexPath.row]
        } 
        cell.textLabel?.text = device.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDevice = devices[indexPath.row]
        present(DetailViewController(device: selectedDevice), animated: false)
    }
}





