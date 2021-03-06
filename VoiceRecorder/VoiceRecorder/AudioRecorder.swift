//
//  AudioRecorder.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/03.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    private var audioRecorder: AVAudioRecorder!
    
    private(set) var recordings = [Recording]()
    
    private(set) var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    private var timer : Timer!
    
    let timeInterval = 0.05
    let numberOfSamples = 60
    
    private(set) var currentTime : Double {
        didSet {
            objectWillChange.send(self)
        }
    }
    private(set) var averagePowerList : [Float]
    
    
    override init() {
        self.currentTime = 0.00
        self.averagePowerList = [Float](repeating: -160.0, count: numberOfSamples)
        super.init()
        fetchRecordings()
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "YY-MM-dd_'at'_HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.isMeteringEnabled = true
            
            self.timer?.invalidate()
            self.currentTime = 0.00
            self.averagePowerList = [Float](repeating: -160.0, count: numberOfSamples)
            
            audioRecorder.record()
            recording = true
            
            self.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {
                 _ in
                self.audioRecorder.updateMeters()
                let temp = self.averagePowerList.dropFirst(1)
                self.averagePowerList = temp + [self.audioRecorder.averagePower(forChannel: 0)]
                self.currentTime = self.audioRecorder.currentTime
            }
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        self.timer?.invalidate()
        
        fetchRecordings()
    }
    
    func fetchRecordings() {
        recordings.removeAll()
            
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
                
        objectWillChange.send(self)
    }
    
    func deleteRecording(urlsToDelete: [URL]) {
        for url in urlsToDelete {
            print(url)
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("File could not be deleted!")
            }
        }
            
        fetchRecordings()
    }
    
    func updateRecordingName(from urlsToMoveFrom: URL, to urlsToMoveTo: URL) {
        do {
            try FileManager.default.moveItem(at: urlsToMoveFrom, to: urlsToMoveTo)
        } catch {
            print("File could not be Renamed!")
        }
        
        fetchRecordings()
    }
}
