//
//  VoiceRecorderView.swift
//  voiceMemo
//

import SwiftUI

struct VoiceRecorderView: View {
    
    @StateObject private var voiceRecorderViewModel  = VoiceRecorderViewModel()
    
    var body: some View {
        //타이틀 뷰
        
        // 안내뷰
        // 보이스 레코더 리스트 뷰
        
        Text("HI")
    }
}

struct VoiceRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecorderView()
    }
}
