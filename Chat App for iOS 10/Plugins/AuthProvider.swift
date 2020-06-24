//
//  AuthProvider.swift
//  Chat App for iOS 10
//
//  Created by apple on 6/7/18.
//  Copyright © 2018 Frank Nerdy. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias LoginHandler = (_ msg: String?) -> Void;

//let user = Auth.auth().currentUser
//let uid = user?.uid
//let email = user?.email
//if let user = user {
    // The user's ID, unique to the Firebase project.
    // Do NOT use this value to authenticate with your backend server,
    // if you have one. Use getTokenWithCompletion:completion: instead.
    //let uid = user.uid
    //let email = user.email
    //let photoURL = user.photoURL
    // ...
//}

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid Email Address, Please Provide A Real Email Address";
    static let WRONG_PASSWORD = "Wrong Password, Please Enter the Correct Password";
    static let PROBLEM_CONNECTING = "Problem Connecting To Database, Please try later";
    static let USER_NOT_FOUND = "User Not Found, Please Register";
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Use Another Email";
    static let WEAK_PASSWORD = "Password Should Be At Least 6 Characters Long";
}

class AuthProvider {
    private static let _instance = AuthProvider();
    
    static var Instance: AuthProvider{
        return _instance;
    }
    var userName = "";
    //var userUid = "";
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: {(user,Error)in
            if Error != nil {
                self.handleErrors(err: Error as! NSError, loginHandler: loginHandler);
            }else {
                loginHandler?(nil);
            }
            
            
        });
    } // login func
    
    func isLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true;
        }
        return false;
    }
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut();
                return true;
            }catch {
                return false;
            }
        }
        return true;
    }
    
    func userID() -> String {
        return Auth.auth().currentUser!.uid;
    }
    
    func signUp(withEmail: String, password: String, loginHandler: LoginHandler?) {
        Auth.auth().createUser(withEmail: withEmail, password: password, completion: {(user,Error)in
            if Error != nil {
                self.handleErrors(err: Error as! NSError, loginHandler: loginHandler);
            }else {
                let user = Auth.auth().currentUser
                let uid = user?.uid
                let email = user?.email
                //if let user = user {
                   // self.userUid = user.
                //}
               // if let user = user {
                  //self.userUid = user.uid
                //if user.uid
                if user?.uid != nil {
                    DBProvider.Instance.saveUser(withID: user!.uid, email: withEmail, password: password);
                    //Instance.saveUser(withID: user!.uid, email: withEmail, password: password);
                    //login the user
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
                    
                }
                
                loginHandler?(nil);
            }
            
            
        });
    
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
        if let errCode = AuthErrorCode(rawValue: err.code) {
            switch errCode {
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
                
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
            case .userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
                
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                break;
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
            }
        }
    }
    
} //class



