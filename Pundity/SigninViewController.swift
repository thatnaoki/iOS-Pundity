//
//  ViewController.swift
//  Pundity
//
//  Created by Naoki Muroya on 2019/01/28.
//  Copyright © 2019 thatnaoki. All rights reserved.
//

import UIKit
import FirebaseAuth
import TwitterKit

class SigninViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                let authToken = session!.authToken
                let authTokenSecret = session!.authTokenSecret
                let credential = TwitterAuthProvider.credential(withToken: authToken, secret: authTokenSecret)
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    print(authResult as Any)
                    self.performSegue(withIdentifier: "signinToIndex", sender: nil)
                }
            } else {
                print("error: \(error!.localizedDescription)")
            }
        })
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
    }

}

