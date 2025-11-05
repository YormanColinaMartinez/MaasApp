//
//  AlertView.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import UIKit

func showAddCardAlert(onAdd: @escaping (String?) -> Void) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let rootVC = windowScene.windows.first?.rootViewController else {
        return
    }

    let alert = UIAlertController(
        title: "Agregar nueva tarjeta",
        message: "Introduce el número de tu tarjeta (máx. 16 dígitos):",
        preferredStyle: .alert
    )
    
    alert.addTextField { textField in
        textField.placeholder = "Número de tarjeta"
        textField.keyboardType = .numberPad
        
        NotificationCenter.default.addObserver(
            forName: UITextField.textDidChangeNotification,
            object: textField,
            queue: .main
        ) { _ in
            if let text = textField.text, text.count > 16 {
                textField.text = String(text.prefix(16))
            }
        }
    }
    
    let addAction = UIAlertAction(title: "Aceptar", style: .default) { _ in
        if let text = alert.textFields?.first?.text, text.count == 16 {
            onAdd(text)
        } else {
            let errorAlert = UIAlertController(
                title: "Error",
                message: "El número de tarjeta debe tener exactamente 16 dígitos.",
                preferredStyle: .alert
            )
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
            rootVC.present(errorAlert, animated: true)
            onAdd(nil)
        }
    }
    
    let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
        onAdd(nil)
    }
    
    alert.addAction(addAction)
    alert.addAction(cancelAction)
    
    rootVC.present(alert, animated: true)
}
