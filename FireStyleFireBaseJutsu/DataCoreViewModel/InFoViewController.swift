//
//  InFoViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/30/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

class InFoViewController: VelocityAnimaViewController {
    
    @IBOutlet weak var inFoTableView: UITableView!
    
    let dCoreViewModel = DataCoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inFoTableView.delegate = self
        inFoTableView.dataSource = self
        
        dCoreViewModel.fetchConnection() // crucial 
        
        print(dCoreViewModel.connectionsCollection)
    }
    
    @IBAction func createButtonTouched(_ sender: UIBarButtonItem) {
        
        let connectionGeneratorAlert = UIAlertController(title: "Create New Connection", message: nil, preferredStyle: .alert)
          
        connectionGeneratorAlert.addTextField { (textField) in
            textField.placeholder = "Name?"
        }
        connectionGeneratorAlert.addTextField { (textField) in
            textField.placeholder = "Digits?"
        }
        
        let cancellation = UIAlertAction(title: "Cancel~", style: .cancel) { (act) in print(act) }
        
        let creation = UIAlertAction(title: "Create~", style: .default) { [weak self] (_) in
            
            guard let coverContent = connectionGeneratorAlert.textFields?.first?.text else { return }
            guard let dialContent = connectionGeneratorAlert.textFields?[1].text else { return }
            
            print(coverContent)
            print(dialContent)
            
            self?.dCoreViewModel.createOneNewConnection(cover: coverContent, dial: dialContent)
    
            DispatchQueue.main.async {
                self?.inFoTableView.reloadData()
            }
        }
         
        [cancellation, creation].map({connectionGeneratorAlert.addAction($0)})

        present(connectionGeneratorAlert, animated: true, completion: nil)
    }
}

extension InFoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cello = inFoTableView.dequeueReusableCell(withIdentifier: "InFoCello", for: indexPath) as! InFoCello
        
    //    dCoreViewModel.fetchConnection() // 必要吗?
        
//        cello.textLabel?.text = ""// dCoreViewModel.getCoverAndDial(indexPathDotRow: indexPath.row)[0]
//        cello.detailTextLabel?.text = dCoreViewModel.getCoverAndDial(indexPathDotRow: indexPath.row)[1]
        
        cello.digitsLabel.text = dCoreViewModel.getCoverAndDial(indexPathDotRow: indexPath.row)[0]
        
        cello.cognomenLabel.text = dCoreViewModel.getCoverAndDial(indexPathDotRow: indexPath.row)[1]
        
        print(cello.snapShotImageView.image)
        
        return cello
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfConnections = dCoreViewModel.getNumbOfConnections()
        print(numOfConnections)
        return numOfConnections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        dCoreViewModel.fetchConnection() // 必须吗?
        
        if editingStyle == .delete {
            dCoreViewModel.deleteConnection(indexPathDotRow: indexPath.row)
            
            DispatchQueue.main.async {
                self.inFoTableView.reloadData()
            }
        }
    }
}

//            self?.dCoreViewModel.createOneNewConnection(cover: "Julianne", dial: "301-517-6767")

extension InFoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        inFoTableView.deselectRow(at: indexPath, animated: true)
        
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let xjViewController = sBoard.instantiateViewController(withIdentifier: "XJViewController")
        navigationController?.pushViewController(xjViewController, animated: true)
        
    }

}
