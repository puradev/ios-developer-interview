//
//  QuickLookView.swift
//  SampleApp
//
//  Created by Kody Holman on 2/7/24.
//

import SwiftUI
import QuickLook

struct QuickLookView: UIViewControllerRepresentable {
    
    var fileURL: URL
    
    func makeCoordinator() -> Coordinator {
        Coordinator(fileURL: fileURL)
    }
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let previewController = QLPreviewController()
        previewController.dataSource = context.coordinator
        return previewController
    }
    
    func updateUIViewController(_ previewController: QLPreviewController, context: Context) {
        context.coordinator.fileURL = fileURL
        previewController.reloadData()
    }
    
    class Coordinator: QLPreviewControllerDataSource {
        
        var fileURL: URL
        
        init(fileURL: URL) {
            self.fileURL = fileURL
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            1
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            fileURL as NSURL
        }
    }
}

#Preview {
    QuickLookView(fileURL: Bundle.main.url(forResource: "Pura", withExtension: "usdz")!)
}
