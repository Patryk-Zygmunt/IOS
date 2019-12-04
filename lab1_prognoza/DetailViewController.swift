//
//  DetailViewController.swift
//  lab1_prognoza
//
//  Created by Student on 30/10/2018.
//  Copyright © 2018 Zygmunt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var cityToFind = "";

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCity(_ sender: Any) {
        //cities.append(self.cityToFind)
    }
    @IBAction func textFileld(_ sender: UITextField) {
        self.cityToFind = sender.text!
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
