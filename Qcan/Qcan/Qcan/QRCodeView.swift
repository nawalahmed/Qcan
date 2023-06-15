//
//  ContentView.swift
//  Qcan
//
//  Created by Nawal Ahmed on 15/06/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let string: String
    
    var body: some View {
        if let qrCodeImage = generateQRCode(from: string) {
            Image(uiImage: qrCodeImage)
                .resizable()
                .interpolation(.none)
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: .ascii)
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        
        return nil
    }
}
