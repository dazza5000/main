# Contributing

Everyone is welcome to contribute to the WinWisely application, including adding new screens, fixing current issues or suggesting enhancements.

To do so, please read the following sections:
- [Opening an Issue](#opening-an-issue)
- [Creating A Pull Request](#creating-a-pull-request)
- [Style Guide](#style-guide)


# Opening an Issue

## New Feature/Feature Request

When filing a bug, please follow the [Github Feature Request Guideline](https://github.com/winwisely99/main/blob/master/.github/ISSUE_TEMPLATE/FEATURE-REQUEST1.md)


## Issue or Bug
When filing a bug, please follow the [Github Bug Guideline](https://github.com/winwisely99/main/blob/master/.github/ISSUE_TEMPLATE/BUG.md)

# Creating a Pull Request
If you are going to work on an issue, please let others know that by commenting the issue page. We will then assign it to you.

When creating a Pull Request, please make sure your code follows the [Style Guide](#style-guide). 

This project follows the [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) structure in the git tree, so when creating a new feature or fixing an issue, please create the appropriate branch in the `development` branch. When your feature is finished, merge it back into `development` and create your pull request.

Additionally, each commit message must follow this set of rules:
- Reference the issue that you are fixing/adding as a feature
- Explain what the commit does (“Fixes issue #1), “Adds a button to the bottom bar for ‘Home’”)
- Use the present tense (“Add feature” not “Added feature”)
- Use the imperative mood (“Move cursor to…” not “Moves cursor to…”)

# Style Guide
When creating a pull-request to the VOST repo, you must:
- Format the code with  `dartfmt`
- Comment any added Functions and Methods according to the [Official Dart Recommendations](https://www.dartlang.org/guides/language/effective-dart/documentation) for commenting code.