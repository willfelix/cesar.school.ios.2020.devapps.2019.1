    //
    //  ConsolesTableViewController.swift
    //  MyGames
    //
    //  Created by Douglas Frari on 16/05/20.
    //  Copyright © 2020 Douglas Frari. All rights reserved.
    //
    
    import UIKit
    import CoreData
    
    class ConsolesTableViewController: UITableViewController {
        
        // esse tipo de classe oferece mais recursos para monitorar os dados
        var fetchedResultController:NSFetchedResultsController<Console>!
        
        // tip. podemos passar qual view vai gerenciar a busca. Neste caso a própria viewController (logo usei nil)
        let searchController = UISearchController(searchResultsController: nil)
        
        var label = UILabel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // mensagem default
            label.text = "Você não tem plataformas cadastradas"
            label.textAlignment = .center
            
            // altera comportamento default que adicionava background escuro sobre a view principal
            
            // searchController.dimsBackgroundDuringPresentation = false
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.tintColor = .white
            searchController.searchBar.barTintColor = .white
            
            navigationItem.searchController = searchController
            
            // usando extensions
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
            
            loadConsoles()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // se ocorrer mudancas na entidade Console, a atualização automatica não irá ocorrer porque nosso NSFetchResultsController esta monitorando a entidade Game. Caso tiver mudanças na entidade Console precisamos atualizar a tela com a tabela de alguma forma: reloadData :)
            tableView.reloadData()
        }
        
        func loadConsoles(filtering: String = "") {
            
            let fetchRequest: NSFetchRequest<Console> = Console.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            if filtering.isEmpty == false {
                // COMO SE FOSSE WHERE do SQL
                // usando predicate: conjunto de regras para pesquisas
                // contains [c] = search insensitive (nao considera letras identicas)
                let predicate = NSPredicate(format: "name contains [c] %@", filtering)
                fetchRequest.predicate = predicate
            }
            
            // possui
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultController.delegate = self
            
            do {
                try fetchedResultController.performFetch()
            } catch  {
                print(error.localizedDescription)
            }
            
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let count = fetchedResultController?.fetchedObjects?.count ?? 0
            tableView.backgroundView = count == 0 ? label : nil
            return count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConsoleTableViewCell
            guard let console = fetchedResultController.fetchedObjects?[indexPath.row] else {
                return cell
            }
            cell.prepare(with: console)
            return cell
        }
        
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {
                    print("Nao foi possivel obter o Console da linha selecionada para deletar")
                    return
                }
                context.delete(game) // foi escalado para ser deletado, mas precisamos confirmar com save
                
                do {
                    try context.save()
                    // efeito visual deletar poderia ser feito aqui, porem, faremos somente se o banco de dados
                    //reagir informando que ocorreu uma mudanca (NSFetchedResultsControllerDelegate)
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            
            if segue.identifier! == "consoleSegue" {
                print("consoleSegue")
                let vc = segue.destination as! ConsoleViewController
                
                if let consoles = fetchedResultController.fetchedObjects {
                    vc.console = consoles[tableView.indexPathForSelectedRow!.row]
                }
                
            } else if segue.identifier! == "newConsoleSegue" {
                print("newConsoleSegue")
            }
        }
        
    }
    
    extension ConsolesTableViewController: NSFetchedResultsControllerDelegate {
        
        // sempre que algum objeto for modificado esse metodo sera notificado
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            
            switch type {
            case .delete:
                if let indexPath = indexPath {
                    // Delete the row from the data source
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            default:
                tableView.reloadData()
            }
        }
    }
    
    extension ConsolesTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
        
        func updateSearchResults(for searchController: UISearchController) {
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            loadConsoles()
            tableView.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            loadConsoles(filtering: searchBar.text!)
            tableView.reloadData()
        }
    }
