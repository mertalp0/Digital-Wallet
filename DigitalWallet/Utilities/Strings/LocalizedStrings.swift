//
//  LocalizedStrings.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//

import Foundation

final class LocalizedStrings {
    struct Login {
        static var emailPlaceholder: String {
            return NSLocalizedString("login_email_placeholder", comment: "Placeholder for email text field")
        }
        static var passwordPlaceholder: String {
            return NSLocalizedString("login_password_placeholder", comment: "Placeholder for password text field")
        }
        static var loginButton: String {
            return NSLocalizedString("login_button", comment: "Login button title")
        }
        static var goToRegisterButton: String {
            return NSLocalizedString("login_go_to_register_button", comment: "Go to Register button title")
        }
        static var alertTitle: String {
            return NSLocalizedString("login_alert_title", comment: "Alert title")
        }
    }
    
    struct Register {
        static var fullnamePlaceholder: String {
            return NSLocalizedString("register_fullname_placeholder", comment: "Placeholder for full name text field")
        }
        static var emailPlaceholder: String {
            return NSLocalizedString("register_email_placeholder", comment: "Placeholder for email text field")
        }
        static var passwordPlaceholder: String {
            return NSLocalizedString("register_password_placeholder", comment: "Placeholder for password text field")
        }
        static var confirmPasswordPlaceholder: String {
            return NSLocalizedString("register_confirm_password_placeholder", comment: "Placeholder for confirm password text field")
        }
        static var registerButton: String {
            return NSLocalizedString("register_button", comment: "Register button title")
        }
    }
    
    struct Home {
        static var availableBalance: String {
            return NSLocalizedString("home_available_balance", comment: "Available balance text")
        }
        static var spentDescription: String {
            return NSLocalizedString("home_spent_description", comment: "Spent description text")
        }
        static var activityTitle: String {
            return NSLocalizedString("home_activity_title", comment: "Activity section title")
        }
        static var spentTitle: String {
                 return NSLocalizedString("expense_card_spent_title", comment: "Title for spent section")
             }
             static var earnedTitle: String {
                 return NSLocalizedString("expense_card_earned_title", comment: "Title for earned section")
             }
           
             static var moreInfoLink: String {
                 return NSLocalizedString("expense_card_more_info_link", comment: "More info link text")
             }
    }
}
