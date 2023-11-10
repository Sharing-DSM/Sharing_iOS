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

    // chat
    case chatRequired

    // profile
    case profileRequired

    //Alert
    case alertRequired(title: String, content: String)
    case errorAlertRequired(content: String)

    //Test
    case testRequired

    // Post
    case postDetailRequired(id: String)
    case succeedCreatePostRequired
    case succeedDeletePostRequired
}
