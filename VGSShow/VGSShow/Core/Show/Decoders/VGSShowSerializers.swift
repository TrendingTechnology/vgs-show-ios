//
//  VGSShowSerializers.swift
//  VGSShow
//
//  Created by Eugene on 27.10.2020.
//

import Foundation

final class VGSShowTextDecoder: VGSShowDecoderProtocol {

	// MARK: - VGSShowDecoderProtocol

	/// Serialize data by specified path.
	/// - Parameters:
	///   - path: `String` object. Path for serialization.
	///   - data: `Data?` object. Raw data to serialize.
	/// - Returns: `VGSShowSerializerResult` object. `success` if object is found, failure with associated error.
	func decodeDataPyPath(_ path: VGSJSONKeyPath, data: Data?) -> VGSShowSerializerResult {
		guard let rawData = data else {
			return .failure(VGSShowError(type: .noRawData))
		}

		guard let jsonData = try? JSONSerialization.jsonObject(with: rawData, options: []) as? JsonData else {
			return .failure(VGSShowError(type: .invalidJSON))
		}

		guard let serializedText: String = jsonData.valueForKeyPath(keyPath: path) else {
			return .failure(VGSShowError(type: .valueNotFoundInJSON))
		}

		let textResult = VGSShowResultData.text(serializedText)

		return .success(textResult)
	}
}