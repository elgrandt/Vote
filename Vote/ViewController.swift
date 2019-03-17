//
//  ViewController.swift
//  Vote
//
//  Created by Dylan Tasat on 01/03/2019.
//  Copyright © 2019 Dylan Tasat. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    func jumpView(current : String, next : String) {
        let storyboard = UIStoryboard(name: current, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: next)
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func submit(_ sender: UIButton) {
        let key = sender.currentTitle!.lowercased()
        ref.child("votos").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let old_value = value!.value(forKey: key) as? Int
            if (old_value != nil) {
                self.ref.child("votos/\(key)").setValue(old_value!+1)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        jumpView(current: "Main", next: "Results")
    }
}

