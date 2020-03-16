//
//  WorldCupViewController.swift
//  CampeoesCopas
//
//  Created by aluno on 29/02/20.
//  Copyright © 2020 Cesar School. All rights reserved.
//

import UIKit

class WorldCupViewController: UIViewController {

    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var ivVice: UIImageView!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbWinner: UILabel!
    @IBOutlet weak var lbVice: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var worldCup: WorldCup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Copa do Mundo \(worldCup.year)"
        
        // TODO: abordagem usada para setar o nome do arquivo nao é a melhor forma. O ideal seria criar outra propriedade no Json para esse nome.
        ivWinner.image = UIImage(named: worldCup.winner)
        ivVice.image = UIImage(named: worldCup.vice)
        lbScore.text = "\(worldCup.winnerScore) x \(worldCup.viceScore)"
        lbWinner.text = worldCup.winner
        lbVice.text = worldCup.vice
        
        // para registrar programaticamente o datasource, use:
        //tableView.dataSource = self
        // ou em nosso caso estamos usando o metodo pelo Interface Builder (no storyboard)
        
    }
    
    
    
} // fim da classe

/*
// UITableViewDataSource
numberOfSections (OPCIONAL)
numberOfRowsInSection (OBRIGATORIO)
cellForRowAt (OBRIGATORIO)
titleForHeaderInSection (OPCIONAL)
 
// UITableViewDelegate
- nao necessario, a menos que quisermos tratar o clique na cell
*/
extension WorldCupViewController:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // total de secoes disponiveis (cada fase representara uma secao, Oitavas, Semifinais, Finais...)
        return worldCup.matches.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // numero de linhas de cada etapa (ex. Oitavas, Semifinais, Finais...)
        let games = worldCup.matches[section].games
        return games.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // recuperando o Game que se encontra em algum Match (oitavas de final, quartas, semi...)
        let match = worldCup.matches[indexPath.section]
        let game = match.games[indexPath.row]
               
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
        cell.prepare(with: game)
               
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // obter o nome da etapa atual da copa
        
        let match = worldCup.matches[section]
        return match.stage        
        
    }
    
    
    
    
    
}





