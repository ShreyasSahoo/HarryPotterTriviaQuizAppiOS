//
//  Store.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 06/05/24.
//

import Foundation
import StoreKit
enum BookStatus {
    case active
    case inactive
    case locked
}

@MainActor
class Store : ObservableObject {
    @Published var books: [BookStatus] = [.active,.active,.inactive,.locked,.locked,.locked,.locked]
    @Published var products : [Product] = []
    @Published var purchasedIDs = Set<String>()
    private var productIDs = ["hp4","hp5","hp6","hp7"]
    private var updates : Task<Void,Never>? = nil
    init(){
        updates = watchForUpdates()
    }
    func loadProducts() async {
        do {
            products  = try await Product.products(for: productIDs)
        } catch {
            print("Couldn't fetch those products")
        }
    }
    
    func purchase(_ product : Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
          //purchase successful,  but now we have to verify receipt
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified(let signedType, let verificationError):
                    print("Error on \(signedType) : \(verificationError)")
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                }
                //user cancelled or parent disapproved of the child's purchase
            case .userCancelled:
                break
                //waiting for approval
                
                
                
            case .pending:
                break
            @unknown default:
                break
            }
        } catch {
            print("Couldn't purchase that product")
        }
    }
    private func checkPurchased() async {
        for product in products {
            guard let state = await product.currentEntitlement else { return }
            
            switch state {
            case .unverified(let signedType, let verificationError):
                print("Error on \(signedType) : \(verificationError)")
            case .verified(let signedType):
                if signedType.revocationDate == nil {
                    purchasedIDs.insert(signedType.productID)
                } else {
                    purchasedIDs.remove(signedType.productID)
                }
            }
        }
    }
    private func watchForUpdates () -> Task<Void,Never> {
        Task(priority: .background){
            for await _ in Transaction.updates {
                await checkPurchased()
            }
        }
    }
}