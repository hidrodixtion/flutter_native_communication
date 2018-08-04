//
//  SecondViewController.swift
//  Runner
//
//  Created by Adi Nugroho on 03/08/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var bodyTitle: String?
    
    @IBOutlet weak var txtTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtTitle.text = bodyTitle
        
        title = "Second VC"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBtnDoneClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
