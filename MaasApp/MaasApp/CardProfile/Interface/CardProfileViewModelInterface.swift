//
//  CardProfileViewModelInterface.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI

protocol CardProfileViewModelInterface: ObservableObject {
    var cardInfo: CardInfo? { get set }
    var cardBalance: CardBalance? { get set }
    func getInformation() async 
    func getBalance() async 
    func deleteCard(cardNumber: String)
}
