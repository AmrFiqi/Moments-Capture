//
//  ViewController.swift
//  Moment Capturer
//
//  Created by Amr El-Fiqi on 08/02/2023.
//

import UIKit

class ImagesTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    private var moments = [Moment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNAvigationItem()
    }
    
    // MARK: - Class Methods.
    
    private func setupNAvigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentImagePicker))
    }
    
    @objc func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func renameAlert(rowDetails: Moment, viewController: ImageDetailViewController) {
        
        let renameAlertController = UIAlertController(title: "Rename: ", message: nil, preferredStyle: .alert)
        renameAlertController.addTextField()
        renameAlertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        renameAlertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self, weak renameAlertController] action in
            guard let newCaption = renameAlertController?.textFields?[0].text else {return}
            rowDetails.name = newCaption
            
            self?.tableView.reloadData()
        }))
        let optionsAlert = optionsAlert(alertController: renameAlertController, viewController: viewController)
        present(optionsAlert, animated: true)
    }
    
    private func optionsAlert(alertController: UIAlertController, viewController: ImageDetailViewController) -> UIAlertController {
        let optionsAlertController = UIAlertController(title: "Choose an option", message: "", preferredStyle: .alert)
        optionsAlertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        optionsAlertController.addAction(UIAlertAction(title: "Rename Caption", style: .default, handler: { [weak self]  action in
            self?.present(alertController , animated: true)
        }))
        optionsAlertController.addAction(UIAlertAction(title: "View Image", style: .default, handler: { action in
            self.navigationController?.pushViewController(viewController, animated: true)
        }))
        return optionsAlertController
    }
    
    private func getRowDetails(atIndex indexPath: IndexPath) -> Moment {
        return moments[indexPath.row]
    }
    
    private func getPath(ofSelectedMoment selectedMoment: Moment) -> String {
        return getDocumentsDirectory().appendingPathComponent(selectedMoment.image).path
    }
    
    // MARK: - Table View Delegate Methods.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let momentCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MomentCell else { return UITableViewCell() }
        
        let selectedMoment = getRowDetails(atIndex: indexPath)
        momentCell.setupCell(withModel: selectedMoment, imagePath: getPath(ofSelectedMoment: selectedMoment))
        
        return momentCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SelectedImageView") as? ImageDetailViewController else { return }
        let rowDetails = getRowDetails(atIndex: indexPath)
        viewController.selectedItem = getPath(ofSelectedMoment: rowDetails)
        viewController.viewTitle = rowDetails.name
        
        renameAlert(rowDetails: rowDetails, viewController: viewController)
    }
}

// MARK: - Extension.

extension ImagesTableViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 1) {
            try? jpegData.write(to: imagePath)
        }
        
        let moment = Moment(name: "Unknown", image: imageName)
        moments.append(moment)
        tableView.reloadData()
        dismiss(animated: true)
    }
}
