//
//  TelaCadastroViewController.swift
//  TableViewDemo
//
//  Created by aluno on 29/02/20.
//  Copyright © 2020 Cesar School. All rights reserved.
//

import UIKit

class TelaCadastroViewController: UIViewController {

    var carros: [String] = []
    var marcas: [String] = []
    
    // para pegar os valores digitados
    @IBOutlet weak var carroTextField: UITextField!
    @IBOutlet weak var marcaTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // registrando o protocolo para tratar os dados da tabela manualmente aqui
        
        // essa forma é programaticamente, vc pode fazer pela forma Interface Builder (IB)
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    
    @IBAction func salvar(_ sender: UIButton) {
        
        let carro = carroTextField.text!
        let marca = marcaTextField.text!
        
        carros.append(carro)
        marcas.append(marca)
        
        // dica do site:
        // pass variable value by popToViewController in swift https://stackoverflow.com/questions/42669289/pass-variable-value-by-poptoviewcontroller-in-swift
        if let myController  = self.navigationController?.viewControllers[0] as? Tela1TableViewController
        {
            myController.carros = carros
            myController.marcas = marcas
            
            self.navigationController?.popToViewController(myController, animated: true)
        }
        
    }
    
    @IBAction func cancelar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! Tela1TableViewController
        vc.carros = carros
        vc.marcas = marcas
        
    }
    
    
} // fim da classe

extension TelaCadastroViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = carros[indexPath.row]
        cell.detailTextLabel?.text = marcas[indexPath.row]

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tratar eventos clicaveis aqui
        print("clicado no item da tabela: \(indexPath.row)")
    }
}
