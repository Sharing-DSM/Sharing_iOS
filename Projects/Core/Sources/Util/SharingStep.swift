import RxFlow

public enum SharingStep: Step {

    // dummy
    case onBoardingRequired

    // Auth
    case loginRequired
    case signupRequired
    case succeedSignupRequired

    //tabs
    case tabsRequired

    // map
    case mapRequired

    //home
    case homeRequired
    case postWriteRequired

    //profile
    case profileRequired
    case profileEditRequired
    case successProfileEdit
    case createScheduleRequired
    case successCreateSchedule
    case scheduleRequired
    case scheduleEditRequired(id: String)
    case myPostRequired
    case applyHistoryRequired
    case completeScheduleAlertRequired

    // chat
    case chatRequired

    //Alert
    case alertRequired(title: String, content: String)
    case errorAlertRequired(content: String)

    //Test
    case testRequired

    // Post
    case postDetailRequired(id: String)
    case postEditRequired(id: String)
    case popRequired
}
