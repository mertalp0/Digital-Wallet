//
//  LocalizedStrings.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//

import Foundation

final class LocalizedStrings {
    struct Login {
        static var welcomeBack: String {
            return NSLocalizedString("login_welcome_back", comment: "Welcome back text")
        }
        static var signInToContinue: String {
            return NSLocalizedString("login_sign_in_to_continue", comment: "Sign in to continue text")
        }
        static var emailPlaceholder: String {
            return NSLocalizedString("login_email_placeholder", comment: "Email placeholder")
        }
        static var passwordPlaceholder: String {
            return NSLocalizedString("login_password_placeholder", comment: "Password placeholder")
        }
        static var forgotPassword: String {
            return NSLocalizedString("login_forgot_password", comment: "Forgot Password text")
        }
        static var signInButton: String {
            return NSLocalizedString("login_sign_in_button", comment: "Sign in My Account button text")
        }
        static var dontHaveAccount: String {
            return NSLocalizedString("login_dont_have_account", comment: "Don't have an account text")
        }
        static var signUp: String {
            return NSLocalizedString("login_sign_up", comment: "Sign Up button text")
        }
    }
    
    struct Register {
        static var welcome: String {
            return NSLocalizedString("register_welcome", comment: "Welcome text")
        }
        static var provideDetails: String {
            return NSLocalizedString("register_provide_details", comment: "Provide details for new account text")
        }
        static var fullNamePlaceholder: String {
            return NSLocalizedString("register_full_name_placeholder", comment: "Full Name placeholder")
        }
        static var emailAddressPlaceholder: String {
            return NSLocalizedString("register_email_address_placeholder", comment: "Email Address placeholder")
        }
        static var passwordPlaceholder: String {
            return NSLocalizedString("register_password_placeholder", comment: "Password placeholder")
        }
        static var confirmPasswordPlaceholder: String {
            return NSLocalizedString("register_confirm_password_placeholder", comment: "Confirm Password placeholder")
        }
        static var termsConditions: String {
            return NSLocalizedString("register_terms_conditions", comment: "Terms and Conditions text")
        }
        static var signUpButton: String {
            return NSLocalizedString("register_sign_up_button", comment: "Sign up my Account button text")
        }
        static var alreadyHaveAccount: String {
            return NSLocalizedString("register_already_have_account", comment: "Already have an account text")
        }
        static var signIn: String {
            return NSLocalizedString("register_sign_in", comment: "Sign In button text")
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

    struct AuthenticationError {
        static var firebaseError: String {
            return NSLocalizedString("auth_firebase_error", comment: "Firebase error description")
        }
        static var firebaseDocumentNotFound: String {
            return NSLocalizedString("auth_firebase_document_not_found", comment: "Firebase document not found description")
        }
        static var firebaseDataCorrupted: String {
            return NSLocalizedString("auth_firebase_data_corrupted", comment: "Firebase data corrupted description")
        }
        static var userNotAuthenticated: String {
            return NSLocalizedString("auth_user_not_authenticated", comment: "User not authenticated description")
        }
        static var userNotFound: String {
            return NSLocalizedString("auth_user_not_found", comment: "User not found description")
        }
        static var emailNotVerified: String {
            return NSLocalizedString("auth_email_not_verified", comment: "Email not verified description")
        }
        static var userNotCreated: String {
            return NSLocalizedString("auth_user_not_created", comment: "User not created description")
        }
        static var accountCreationFailed: String {
            return NSLocalizedString("auth_account_creation_failed", comment: "Account creation failed description")
        }
        static var encryptionFailed: String {
            return NSLocalizedString("auth_encryption_failed", comment: "Encryption failed description")
        }
    }

    struct UserError {
        static var userNotAuthenticated: String {
            return NSLocalizedString("user_error_not_authenticated", comment: "User not authenticated description")
        }
        static var userDocumentNotFound: String {
            return NSLocalizedString("user_error_document_not_found", comment: "User document not found description")
        }
        static var userDataCorrupted: String {
            return NSLocalizedString("user_error_data_corrupted", comment: "User data corrupted description")
        }
        static var firebaseError: String {
            return NSLocalizedString("user_error_firebase_error", comment: "Firebase error description")
        }
    }

    struct AccountError {
        static var documentNotFound: String {
            return NSLocalizedString("account_error_document_not_found", comment: "Account document not found description")
        }
        static var dataCorrupted: String {
            return NSLocalizedString("account_error_data_corrupted", comment: "Account data corrupted description")
        }
        static var firebaseError: String {
            return NSLocalizedString("account_error_firebase_error", comment: "Firebase error description")
        }
    }
}
