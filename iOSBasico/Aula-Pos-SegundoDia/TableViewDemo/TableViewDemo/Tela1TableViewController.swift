//
//  Tela1TableViewController.swift
//  TableViewDemo
//
//  Created by aluno on 29/02/20.
//  Copyright © 2020 Cesar School. All rights reserved.
//

import UIKit

class Tela1TableViewController: UITableViewController {

    // model
    var carros: [String] = []
    var marcas: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        carros.append("Fusca")
        marcas.append("Volkswagen")
        
        carros.append("Jeep Renegade")
        marcas.append("Jeep")
        
        carros.append("Gol")
        marcas.append("Volkswagen")
        
        carros.append("Fiesta")
        marcas.append("Ford")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // atualizar a tabela porque pode ter novos dados
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // pode apagar o metodo também, porque o default é 1.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = carros[indexPath.row]
        cell.detailTextLabel?.text = marcas[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cadastrarCarro" {
                       
            let vc = segue.destination as! TelaCadastroViewController
            vc.carros = carros
            vc.marcas = marcas
            
        } else {
            // obtemos a viewController da tela target
            let vc = segue.destination as! TelaCarroViewController
            // obter o indice a selecao do usuario e pegamos o conteudo no array,
            // entao passamos o valor obtido para a propriedade da classe destino
            // que criamos para esse fim
            let indexSelected = tableView.indexPathForSelectedRow!.row
            vc.carro = "\(carros[indexSelected])/\(marcas[indexSelected])"
        }
        
        
    }
    

} // fim da classe

