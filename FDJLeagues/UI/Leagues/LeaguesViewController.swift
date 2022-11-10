//
//  LeaguesViewController.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import UIKit

class LeaguesViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: LeaguesViewModel

    // MARK: - Initialization

    init?(coder: NSCoder, viewModel: LeaguesViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
