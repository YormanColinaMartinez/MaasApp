//
//  CardProfileView.swift
//  MaasApp
//
//  Created by mac on 4/11/25.
//

import SwiftUI

struct CardProfileView<ViewModel: CardProfileViewModelInterface>: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ViewModel
    @State private var showingDeleteAlert = false
    var onDelete: (() -> Void)?

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 30) {
                    headerSection
                    cardInfoSection
                    balanceSection
                }
            }

            // 🔹 Botón de borrar tarjeta
            Button(action: {
                showingDeleteAlert = true
            }) {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Borrar Tarjeta")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(12)
                .shadow(color: .red.opacity(0.3), radius: 8, x: 0, y: 4)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("¿Estás seguro?"),
                    message: Text("¿Seguro que deseas borrar la tarjeta número \(maskedCardNumber)?"),
                    primaryButton: .destructive(Text("Borrar")) {
                        viewModel.deleteCard(cardNumber: viewModel.cardInfo?.cardNumber ?? "")
                        onDelete?()
                        dismiss()
                    },
                    secondaryButton: .cancel(Text("Cancelar"))
                )
            }
        }
        .onAppear {
            Task {
                await viewModel.getInformation()
                await viewModel.getBalance()
            }
        }
    }

    // MARK: - Secciones
    private var headerSection: some View {
        VStack {
            CardView(cardNumber: viewModel.cardInfo?.cardNumber ?? "", width: UIScreen.main.bounds.width)
            Text("Detalle de la Tarjeta")
                .font(.title2.bold())
                .padding(.top, 20)
        }
    }

    private var cardInfoSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Group {
                infoRow(title: "Titular", value: "\(viewModel.cardInfo?.userName ?? "") \(viewModel.cardInfo?.userLastName ?? "")")
                infoRow(title: "Número", value: viewModel.cardInfo?.cardNumber ?? "")
                infoRow(title: "Banco", value: viewModel.cardInfo?.bankName ?? "")
                infoRow(title: "Perfil", value: viewModel.cardInfo?.profile_es ?? "")
                infoRow(title: "Código de Perfil", value: viewModel.cardInfo?.profileCode ?? "")
            }
        }
        .padding(.horizontal, 30)
    }

    private var balanceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Balance de la Tarjeta")
                .font(.headline)
                .padding(.bottom, 5)

            balanceRow(title: "Balance disponible:",
                       amount: viewModel.cardBalance?.balance ?? 0,
                       date: viewModel.cardBalance?.balanceDate ?? "")

            balanceRow(title: "Balance virtual:",
                       amount: viewModel.cardBalance?.virtualBalance ?? 0,
                       date: viewModel.cardBalance?.virtualBalanceDate ?? "")
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 20)
    }

    // MARK: - Helpers UI
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):").font(.headline)
            Spacer()
            Text(value).font(.body)
        }
    }

    private func balanceRow(title: String, amount: Double, date: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.subheadline)
            Text(formatCurrency(amount)).font(.title3.bold())
            Text("Actualizado: \(formattedDate(date))")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }

    // MARK: - Helpers de formato
    private func formattedDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return dateString
    }

    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }

    private var maskedCardNumber: String {
        guard let number = viewModel.cardInfo?.cardNumber, number.count >= 4 else { return "********" }
        let last4 = number.suffix(4)
        return "********\(last4)"
    }
}
