//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import UIKit

class DevicesListViewController: UITableViewController {
    let devices: [DeviceData]
    let onSelect: (DeviceData) -> Void
    
    init(devices: [DeviceData], onSelect: @escaping (DeviceData) -> Void) {
        self.devices = devices
        self.onSelect = onSelect
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath)
        let device = devices[indexPath.row]
        cell.textLabel?.text = device.name
        
        let selectButton = UIButton(type: .system)
        selectButton.setTitle("Select", for: .normal)
        selectButton.frame = CGRect(x: cell.frame.width - 100, y: 10, width: 80, height: 30)
        selectButton.addTarget(self, action: #selector(selectDevice(_:)), for: .touchUpInside)
        selectButton.tag = indexPath.row 
        
        cell.contentView.addSubview(selectButton)
        return cell
    }
    
    // MARK: - Button Action
    
    @objc func selectDevice(_ sender: UIButton) {
        let selectedDevice = devices[sender.tag]
        onSelect(selectedDevice)
    }
}

