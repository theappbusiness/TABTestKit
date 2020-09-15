# Contributing

To contribute to this library you can:

- Raise an issue for:
    - Feature requests and enhancements
    - Bugs
    - Discussing implementation of new feature and API changes
- Raise a pull request
    - Ensure unit tests are written for new code

## Branching strategy

**Do not commit directly to the main branch.**
Follow standard [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) branching procedures:

- **main** - This should exactly mirror what's currently in production. Never commit directly to `main`.
- **develop** - This should be the latest development code and the branch that feeds into `main`.
- **feature/\<issue-number\>/\<issue-name\>** - Used for developing features before submitting for code review. Choose a short, meaningful description of the change being made, such as `swift-3-api-improvements`. Where possible add the Github issue number, e.g `feature/9/swift-3-api-improvements`. If the feature is too large to be code reviewed in one go a base branch can be created where the sub branches will merge into. For this, branch off the main `feature` branch including a short description of what it's for.
- **bugfix/\<issue-number\>/\<issue-name\>** - Used for bug fixes before submitting for code review. Use Github issue number if one exists, e.g `bugfix/666/something-broken`.
- **chore/\<issue-number\>/\<issue-name\>** - Used for code changes that are not part of a feature or bug fix, such as updating automated build settings. Use Github issue number if one exists, e.g `chore/3/updated-ci-configuration`.
- **hotfix/\<issue-number\>/\<issue-name\>** - Used for developing **urgent** fixes, created from `main` rather than `develop`. Follows the same branch naming conventions.

## Pull Requests

Before merging any non-trivial changes into `main`, a pull request should be created and assigned for review by all other active contributors. Ensure the project runs and all unit tests are passing before merging any branches. New changes are expected to be unit tested.

Assign one or more people to the pull request, and once everyone has approved, the changes may be merged into the target branch. Simple pull request can be merged when one other person approved it.Common sense applies.

After merging a PR, delete the source branch if it is sensible to do so.

## Release strategy

Each release should be tagged using [semantic version](http://semver.org/), for example `3.0.1`. Before releasing ensure that the following things are done:

- The CHANGELOG is updated to reflect the changes from the previous version
- The README is updated if it's relevant to do so