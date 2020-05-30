//
//  AddEditViewController.swift
//  Carangas
//
//  Created by Eric Brito.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    var car: Car!
    
    // MARK: - IBOutlets
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if car != nil {
            // modo edicao
            tfBrand.text = car.brand
            tfName.text = car.name
            tfPrice.text = "\(car.price)"
            scGasType.selectedSegmentIndex = car.gasType
            btAddEdit.setTitle("Alterar carro", for: .normal)
        }
        
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        
        if car == nil {
            // adicionar carro novo
            car = Car()
        }
        
        car.name = (tfName?.text)!
        car.brand = (tfBrand?.text)!
        if tfPrice.text!.isEmpty {
            tfPrice.text = "0"
        }
        car.price = Double(tfPrice.text!)!
        car.gasType = scGasType.selectedSegmentIndex
        
        // 1
        if car._id == nil {
            
            REST.save(car: car) { (success) in
                
                if success {
                    // consegui salvar
                    self.goBack()
                } else {
                    // não salvou por algum problema
                    print("Problema ao tentar SALVAR")
                }
                
            }
            
        } else {
            // 2 - edit current car
            REST.update(car: car) { (sucess) in
                if sucess {
                    self.goBack()
                } else {
                    print("Problema ao tentar EDITAR")
                }
            }
        }

        
        
        
        
        
    }
    
    func goBack() {
       
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
       
    }

} // fim da classe
