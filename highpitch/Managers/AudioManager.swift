//
//  RecordManager.swift
//  highpitch
//
//  Created by musung on 10/17/23.
//

import AVFoundation

class AudioManager: NSObject, AVAudioPlayerDelegate {
/// 음성메모 녹음 관련 프로퍼티
var audioRecorder: AVAudioRecorder?

/// 음성메모 재생 관련 프로퍼티
var audioPlayer: AVAudioPlayer?

}

// MARK: - 음성메모 녹음 관련 메서드
extension AudioManager {
    func startRecording() {
        // MARK: 파일 이름 전략은 추후에 확정
        let fileURL = getPath(fileName: "test")
        let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.record()
        } catch {
            print("녹음 중 오류 발생: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

// MARK: - 음성메모 재생 관련 메서드
extension AudioManager {
    func startPlaying(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch {
            print("재생 중 오류 발생: \(error.localizedDescription)")
        }
    }
    func playAt(atTime: Double){
        let offset = atTime/100
        audioPlayer?.currentTime = offset
        audioPlayer?.play()
    }
    func stopPlaying() {
        audioPlayer?.stop()
    }

    func pausePlaying() {
        audioPlayer?.pause()
    }

    func resumePlaying() {
        audioPlayer?.play()
    }
    func getPath(fileName:String) -> URL {
        let dataPath = getDocumentsDirectory()
            .appendingPathComponent("HighPitch").appendingPathComponent("Audio")
        do {
            try FileManager.default
                .createDirectory(at: dataPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating directory: \(error.localizedDescription)")
        }
        return dataPath.appendingPathComponent(fileName + ".m4a")
    }
}
