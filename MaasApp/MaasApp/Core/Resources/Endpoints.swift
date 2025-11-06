//
//  Endpoint.swift
//  MaasApp
//
//  Created by mac on 6/11/25.
//

import Foundation

enum Endpoints: String {
    case cardValidation = "https://osgqhdx2wf.execute-api.us-west-2.amazonaws.com/card/valid/"
    case cardInformation = "https://osgqhdx2wf.execute-api.us-west-2.amazonaws.com/card/getInformation/"
    case transportMap = "https://sisuotp.tullaveplus.gov.co/otp/routers/default"
}
