import Foundation

class TransferServiceError: BaseError {
    enum ErrorType {
        case insufficientFunds
        case unableToRetrieveSenderAccount
        case unableToRetrieveReceiverAccount
        case unableToRetrieveAccountData
        case firebaseError(Error)
    }
    
    private let type: ErrorType
    
    init(type: ErrorType) {
        self.type = type
        super.init(type: .custom(TransferServiceError.errorDescription(for: type)))
    }
    
    private static func errorDescription(for type: ErrorType) -> String {
        switch type {
        case .insufficientFunds:
            return LocalizedStrings.TransferError.insufficientFunds
        case .unableToRetrieveSenderAccount:
            return LocalizedStrings.TransferError.unableToRetrieveSenderAccount
        case .unableToRetrieveReceiverAccount:
            return LocalizedStrings.TransferError.unableToRetrieveReceiverAccount
        case .unableToRetrieveAccountData:
            return LocalizedStrings.TransferError.unableToRetrieveAccountData
        case .firebaseError(let error):
            return String(format: LocalizedStrings.TransferError.firebaseError, error.localizedDescription)
        }
    }
    
    func asNSError() -> NSError {
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: TransferServiceError.errorDescription(for: type)
        ]
        
        return NSError(domain: "com.digitalwallet.TransferServiceError", code: self.errorCode(), userInfo: userInfo)
    }
    
    private func errorCode() -> Int {
        switch type {
        case .insufficientFunds:
            return 1001
        case .unableToRetrieveSenderAccount:
            return 1002
        case .unableToRetrieveReceiverAccount:
            return 1003
        case .unableToRetrieveAccountData:
            return 1004
        case .firebaseError:
            return 1005
        }
    }
}
