//
//  MenubarExtraView.swift
//  highpitch
//
//  Created by yuncoffee on 10/10/23.
//

/**
 /// 1. 현재 선택 된 프로젝트 정보 출력 출력
 /// 2. 선택 된 프로젝트로 연습 하기
 /// 키노트 있을 때만 동작 ->
 ///     2.1 프로젝트가 없을 경우 // 키노트가 열려있을 때만! 없으면 앱 열기
 ///     2.2 프로젝트가 있고, 현재 맨 앞의 키노트와 일치하는 경우 // (굿)
 ///     2.3 프로젝트가 있는데, 현재 맨 앞의 키노트와 일치하지 않는 경우 // 사용자가 설정할 수도?
 ///     2.4 프로젝트가 있는데, 열려있는 모든 키노트와 일치하지 않는 경우 // 안될수도 있어서,,
 ///     2-1-1: 노티피케이션 주기
 /// 3. 연습 그만하기
 /// 4. 프로젝트의 연습 목록
 /// 5. 프로젝트 창 열기
 /// 6. 앱 종료
 
 플러그인
 프로젝트 시작 시 Highpitch 프로젝트로 연결
 프로젝트 있을 시 /없을 시 구분
 종료 시 기능
 음성 파일 저장
 STT택스트 구현 및 저장
 피드백 및 표시해야할 부분을 가공해서 데이터로 저장
 앱 열기
 앱 종료
 
 /// 현재 선택된 키노트 프로젝트를 확인한다.
 /// 앱이 실행 되었을 경우..
 /// 현재 키노트가 열려져 있는지 확인한다.
 /// 키노트가 열려져 있다면?
 ///     - 1. 열려 있는 모든 키노트에서 경로를 조회한다.
 ///     - 2. 조회한 경로를 통해 생성일을 구한다.
 ///     - 3. 생성일로 저장해 놓은 프로젝트를 조회한다.
 ///     - 4.1. 일치하는 프로젝트가 있다면?
 ///             - 그 프로젝트를 selected를 세팅한다.
 ///     - 4.2. 일치하는 프로젝트가 없다면?
 ///             - 새 프로젝트를 selected에 세팅한다.
 ///     - 일치하는 프로젝트 목록으로 Picker의 옵션을 구성한다.
 /// 키노트가 열려져 있지 않다면?
 ///     - 우선 연습 못하게 disabled 처리하자.
 
 */
#if os(macOS)
import SwiftUI
import SwiftData

struct MenubarExtraView: View {
    @Environment(\.openWindow)
    private var openWindow
    
    @Environment(AppleScriptManager.self)
    private var appleScriptManager
    @Environment(FileSystemManager.self)
    private var fileSystemManager
    @Environment(KeynoteManager.self)
    private var keynoteManager
    @Environment(MediaManager.self)
    private var mediaManager
    @Environment(ProjectManager.self)
    private var projectManager
    
    // MARK: 샘플 임시 데이터
    @State
    private var selectedProject: ProjectModel = ProjectModel(
        projectName: "d",
        creatAt: "d",
        keynoteCreation: "dd"
    )
    @State
    private var selectedKeynote: OpendKeynote = OpendKeynote()
    
    @State
    private var keynoteOptions: [OpendKeynote] = []
    
    @State
    private var isRecording = false {
        didSet {
            if isRecording {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isRecording = false
                }
            }
        }
        
    }
    
    @Binding
    var isMenuPresented: Bool
    
    @Environment(\.modelContext)
    var modelContext
    @Query(sort: \ProjectModel.creatAt)
    var projectModels: [ProjectModel]
    
    var body: some View {
        if isMenuPresented {
            ZStack {
                Text("HH")
                    .frame(width: 45, height: 1)
                    .popover(isPresented: $isRecording,
                             arrowEdge: .bottom
                    ) {
                        Text("HHHH!!!!!!!!!!!!!")
                            .padding()
                    }
                    .frame(alignment: .center)
                VStack(spacing: 0) {
                    MenubarExtraHeader(
                        selectedProject: $selectedProject,
                        selectedKeynote: $selectedKeynote,
                        isMenuPresented: $isMenuPresented
                    )
                    MenubarExtraContent(
                        selectedProject: $selectedProject,
                        selectedKeynote: $selectedKeynote,
                        keynoteOptions: $keynoteOptions,
                        isMenuPresented: $isMenuPresented
                    )
                }
                .frame(
                    width: isRecording ? 0 : 400,
                    height: isRecording ? 0 : 440,
                    alignment: .top
                )
                .background(Color.HPGray.systemWhite)
            }
            .frame(alignment: .top)
            .onAppear {
                getIsActiveKeynoteApp()
                updateOpendKeynotes()
                if projectModels.count > 0 {
                    selectedProject = projectModels[0]
                }
                // MARK: 녹음 중일 경우 처리하기
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    isRecording.toggle()
//                }
            }
            .onChange(of: keynoteManager.isKeynoteProcessOpen, { _, newValue in
                if newValue {
                    updateOpendKeynotes()
                }
            })
            .onChange(of: keynoteManager.opendKeynotes) { _, newValue in
                print(newValue)
                keynoteOptions = newValue
                if !newValue.isEmpty {
                    selectedKeynote = newValue[0]
                }
                updateCurrentProject()
            }
            .onChange(of: selectedKeynote, {
                updateCurrentProject()
            })
        }
    }
}

// MARK: - Methods
extension MenubarExtraView {
    private func getIsActiveKeynoteApp() {
        Task {
            let result = await appleScriptManager.runScript(.isActiveKeynoteApp)
            if case .boolResult(let isKeynoteOpen) = result {
                // logic 2
                //                print(isKeynoteOpen)
                keynoteManager.isKeynoteProcessOpen = isKeynoteOpen
            }
        }
    }
    
    private func updateOpendKeynotes() {
        Task {
            if keynoteManager.isKeynoteProcessOpen {
                let result = await appleScriptManager.runScript(.getOpendKeynotes)
                if case .stringArrayResult(let keynotePaths) = result {
                    let opendKeynotes = keynotePaths.map { path in
                        OpendKeynote(path: path, creation: fileSystemManager.getCreationMetadata(path))
                    }
                    keynoteManager.opendKeynotes = opendKeynotes
                }
            }
        }
    }
    
    private func updateCurrentProject() {
        if keynoteManager.opendKeynotes.isEmpty {
            print("is Empty!")
        } else {
            if(projectModels.count > 1) {
                let filtered = projectModels.filter({ project in
                    project.keynoteCreation == selectedKeynote.creation
                })
                if !filtered.isEmpty {
                    print("일치하는 프로젝트: \(filtered[0].projectName)")
                    projectManager.current = filtered[0]
                    selectedProject = projectModels.first!
                } else {
                    print("일치하는 프로젝트가 없음")
                    selectedProject = projectModels.last!
                }
            }
        }
    }
    
    private func openSelectedProject() {
        print("프로젝트 열기")
        if selectedProject.projectName != "새 프로젝트" {
            projectManager.current = selectedProject
            if !projectManager.path.isEmpty {
                projectManager.currentTabItem = 0
                projectManager.path.removeLast()
            }
            openWindow(id: "main")
        }
    }
    
    private func startPractice() {
        if !mediaManager.isRecording {
            print("녹음 시작")
            print(selectedkeynote.path)
            Task {
                await appleScriptManager.runScript(.startPresentation(fileName: selectedkeynote.path))
            }
            mediaManager.isRecording.toggle()
            isMenuPresented.toggle()
            
            // 녹음파일 저장할 fileName 정하고, 녹음 시작!!!
            mediaManager.fileName = mediaManager.currentDateTimeString()
            mediaManager.startRecording()
        } else {
            print("녹음 종료")
            mediaManager.isRecording.toggle()
            
            // 녹음 중지!
            mediaManager.stopRecording()
            // mediaManager.fileName에 음성 파일이 저장되어있을거다!!
            // 녹음본 파일 위치 : /Users/{사용자이름}/Documents/HighPitch/Audio.YYYYMMDDHHMMSS.m4a
            // ReturnZero API를 이용해서 UtteranceModel완성
            Task {
                // MARK: 여기다!!!!!!!!여기다!!!!!!!!여기다!!!!!!!!여기다!!!!!!!!여기다!!!!!!!!
                var tempUtterances: [Utterance] = try await ReturnzeroAPI()
                    .getResult(filePath: mediaManager.getPath(fileName: mediaManager.fileName).path())
                // MARK: 여기다!!!!!!!!여기다!!!!!!!!여기다!!!!!!!!여기다!!!!!!!!여기다!!!!!!!!
                var newUtteranceModels: [UtteranceModel] = []
                
                for tempUtterance in tempUtterances {
                    newUtteranceModels.append(
                        UtteranceModel(
                            startAt: tempUtterance.startAt,
                            duration: tempUtterance.duration,
                            message: tempUtterance.message
                        )
                    )
                }
                
                // 새로운 녹음에 대한 PracticeModel을 만들어서 넣는다!
                var newPracticeModel = PracticeModel(
                    practiceName: "\(selectedProject.practices.count + 1)번째 연습",
                    creatAt: fileNameDateToCreateAtDate(input: mediaManager.fileName),
                    audioPath: mediaManager.getPath(fileName: mediaManager.fileName),
                    utterances: newUtteranceModels, summary: PracticeSummaryModel()
                )
                selectedProject.practices.append(newPracticeModel)
            }
            
        }
    }
    
    private func openSelectedPractice(practice: PracticeModel) {
        projectManager.current = selectedProject
        projectManager.currentTabItem = 1
        if !projectManager.path.isEmpty {
            projectManager.path.removeLast()
        }
        // MARK: - 뷰 갱신 하는 방법으로 변경해야함.!!!
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            projectManager.path.append(practice)
        }
    }
    
    private func quitApp() {
        exit(0)
    }
}

// MARK: - Views
extension MenubarExtraView {
    @ViewBuilder
    private var header: some View {
        HStack {
            Button {
                print("앱 열기")
            } label: {
                Label("홈", systemImage: "house.fill")
                    .labelStyle(.iconOnly)
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)
            Spacer()
            Button {
                openSelectedProject()
            } label: {
                Label("프로젝트 열기", systemImage: "house.fill")
                    .labelStyle(.titleOnly)
            }
            
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    private var sectionProject: some View {
        // 프로젝트의 연습 목록
        HStack(alignment: .bottom) {
            // 현재 선택 된 프로젝트 정보 출력 출력
            /// 키노트가 열려있는 경우,
            VStack(alignment: .leading) {
                Text("현재 열려있는 키노트")
                if !keynoteOptions.isEmpty {
                    Picker("프로젝트", selection: $selectedkeynote) {
                        ForEach(keynoteOptions, id: \.id) { opendKeynote in
                            Text("\(opendKeynote.getFileName())").tag(opendKeynote)
                        }
                    }
                    .labelsHidden()
                } else {
                    Text("현재 열려 있는 키노트 파일이 없네여")
                }
                Text("프로젝트")
                Picker("프로젝트", selection: $selectedProject) {
                    ForEach(projectModels, id: \.self) { project in
                        Text("\(project.projectName)").tag(project)
                    }
                }
                .labelsHidden()
            }
            Spacer()
            // 선택 된 프로젝트로 연습 하기 || 연습 그만하기
            Button {
                startPractice()
            } label: {
                let label = if !mediaManager.isRecording {
                    (text: "연습 시작하기", icon: "play.fill")
                } else {
                    (text: "연습 종료하기", icon: "stop.circle.fill")
                }
                Label(label.text, systemImage: label.icon)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 24)
        .frame(minHeight: 32)
    }
    
    @ViewBuilder
    private var sectionPractice: some View {
        VStack(spacing: 0) {
            if !selectedProject.practices.isEmpty {
                ScrollView {
                    LazyVGrid(columns: [GridItem()], spacing: 8) {
                        ForEach(selectedProject.practices, id: \.self) { practice in
                            HStack {
                                Text(practice.practiceName)
                                Spacer()
                                Button {
                                    openSelectedPractice(practice: practice)
                                } label: {
                                    Text("자세히 보기")
                                }
                            }
                            .padding()
                            .background(Color("000000").opacity(0.1))
                            .cornerRadius(5)
                        }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
            } else {
                VStack {
                    Text("연습 이력이 없네요...")
                }
            }
        }
    }
}

#Preview {
    @State var value: Bool = true
    return MenubarExtraView(isMenuPresented: $value)
        .environment(AppleScriptManager())
        .environment(MediaManager())
        .environment(KeynoteManager())
        .frame(maxWidth: 360, maxHeight: 480)
}
#endif

// MARK: Date.now() -> String으로 변환하는 함수들
extension MenubarExtraView {
    // MediaManager밑에 있는 fileName을 통해서 createAt에 넣을 날짜 생성
    func fileNameDateToCreateAtDate(input: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyyMMddHHmmss"
        
        if let date = inputFormatter.date(from: input) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
            
            let formattedDate = outputFormatter.string(from: date)
            
            return formattedDate
        } else {
            return "Invalid Date"
        }
    }
    
}
