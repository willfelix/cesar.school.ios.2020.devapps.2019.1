//
//  CarsTableViewController.swift
//  Carangas
//
//  Created by Eric Brito on 21/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit
import SideMenu

class CarsTableViewController: UITableViewController {
    
    var cars: [Car] = []
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Carregando dados..."
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadCars), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        self.setupSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    @objc fileprivate func loadCars() {
        REST.loadCars(onComplete: { (cars) in
            self.cars = cars
            self.onFinishRequest()
        }) { (carError) in
            let response: String = REST.translateError(carError)
            self.onFinishRequest(errorMessage: response)
        }
    }
    
    fileprivate func onFinishRequest(errorMessage: String? = nil) {
        self.refreshControl?.endRefreshing()
        
        if errorMessage != nil {
            self.label.text = errorMessage
            self.showAlertError(withTitle: "Obter Carros", withMessage: errorMessage!, isTryAgain: true)
        } else {
            self.label.text = "Não existem carros cadastrados."
            self.tableView.reloadData()
        }
    }
    
    func showAlertError(withTitle titleMessage: String, withMessage message: String, isTryAgain hasRetry: Bool) {
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: .actionSheet)
        
        if hasRetry {
            let tryAgainAction = UIAlertAction(title: "Tentar novamente", style: .default, handler: {(action: UIAlertAction) in
                self.loadCars()
            })
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {(action: UIAlertAction) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            
            alert.addAction(tryAgainAction)
            alert.addAction(cancelAction)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = cars.count == 0 ? label : nil
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let car = cars[indexPath.row]
            
            REST.delete(car: car, onComplete: { (success) in
                self.cars.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }) { (error) in
                let error = REST.translateError(error)
                self.showAlertError(withTitle: "Problema ao Deleter", withMessage: error, isTryAgain: true)
            }
            
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewSegue" {
            let vc = segue.destination as? CarViewController
            vc?.car = cars[tableView.indexPathForSelectedRow!.row]
        }
        
    }
    
}
