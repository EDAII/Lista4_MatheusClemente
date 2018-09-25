//
//  ViewController.swift
//  lista4eda2
//
//  Created by Matheus Azevedo on 24/09/2018.
//  Copyright © 2018 Matheus Azevedo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numero: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tree = AVLTree()
        
        let values = [4, 8, 10, 5, 6, 9, 1, 11, 12, 2, 7, 3, 13]
        
        for v in values {
            tree.insert(value: v)
        }
        
        tree.printOrdered(node: tree.root!)
        
    }
    
    @IBAction func inserirNumero(_ sender: Any) {
        if let n = Int(numero.text!) {
            
        }else {
            print("Invalido")
        }
    }
    


}

