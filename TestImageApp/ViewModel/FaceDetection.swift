//
//  FaceDetection.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//

import UIKit
import Vision

final class FaceDetection {
    func isFaces(in image: UIImage) async -> Bool {
        guard let cgImage = image.cgImage else {
            print("Missing CGImage")
            return false
        }

        let request = VNDetectFaceRectanglesRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: .downMirrored)

        do {
            try handler.perform([request])
            if let results = request.results {
                return !results.isEmpty
            }
        } catch {
            print("Face detection failed: \(error.localizedDescription)")
        }

        return false
    }
}

