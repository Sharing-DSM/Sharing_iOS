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

    //home
    case homeRequired
    case postDetailsRequired
    case postWriteRequired

    //profile
    case profileEditRequired
    case createScheduleRequired
    case scheduleRequired

    //Alert
    case alertRequired(title: String, content: String)
    case errorAlertRequired(content: String)

    //Test
    case testRequired
}
