//
//  MemoView.swift
//  voiceMemo
//

import SwiftUI

struct MemoView: View {
    
    @EnvironmentObject var pathModel : PathModel
    @EnvironmentObject var memoListViewModel : MemoListViewModel
    @StateObject var memoViewModel : MemoViewModel
    @State var isCreateMode : Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(
                    leftBtnAction: {
                        pathModel.paths.removeLast()
                    },
                    rightBtnAction: {
                        if isCreateMode {
                            memoListViewModel.addMemo(memoViewModel.memo)
                        } else {
                            memoListViewModel.updateMemo(memoViewModel.memo)
                        }
                        pathModel.paths.removeLast()
                    },
                    rightBtnType: isCreateMode ? .create : .complete
                )
                
                // 메모 타이틀 인풋 뷰
                MemoTitleInputView(memoViewModel: memoViewModel,
                                   isCreateMode: $isCreateMode)
                .padding(.top, 20)
                // 메모 컨텐츠 인풋 뷰
                MemoContentInputView(memoViewModel: memoViewModel)
                    .padding(.top, 10)
                
                
            }
            
            if !isCreateMode {
                RemoveMemoBtnView(memoViewModel: memoViewModel)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
            }
            
        }
    }
}

// MARK: 메모 제목 입력 뷰
private struct MemoTitleInputView : View {
    @ObservedObject var memoViewModel : MemoViewModel
    @FocusState private var isTitleFieldFocused : Bool
    @Binding private var isCreateMode : Bool
    
    fileprivate init(memoViewModel: MemoViewModel,
                     isCreateMode: Binding<Bool>
    ) {
        self.memoViewModel = memoViewModel
        self._isCreateMode = isCreateMode
    }
    
    fileprivate var body: some View {
        TextField(
            "제목을 입력하세요",
            text: $memoViewModel.memo.title
        )
        .font(.system(size: 30))
        .padding(.horizontal, 20)
        .focused($isTitleFieldFocused)
        .onAppear {
            if isCreateMode {
                isTitleFieldFocused = true
            }
        }
    }
}

// MARK: 메모 본문 입력 뷰
private struct MemoContentInputView : View {
    @ObservedObject var memoViewModel : MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $memoViewModel.memo.content)
                .font(.system(size: 20))
            
            if memoViewModel.memo.content.isEmpty {
                Text("메모를 입력하세요.")
                    .font(.system(size: 16))
                    .foregroundColor(.customGray1)
                    .allowsHitTesting(false) // TextEditor 위에 Text를 올리게 되어 터치 시 TextEditor가 호출되지 않는 것을 방지
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: 메모 삭제 버튼 뷰
private struct RemoveMemoBtnView : View {
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    @ObservedObject private var memoViewModel : MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    memoListViewModel.removeMemo(memoViewModel.memo)
                    pathModel.paths.removeLast()
                } label: {
                    Image("trash")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
            }
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(memoViewModel: .init(
            memo: Memo(title: "",
                       content: "",
                       date: Date())
        )
        )
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
        
    }
}
