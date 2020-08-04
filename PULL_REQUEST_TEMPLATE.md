#### What's in this PR?

Replace this text with information about what's in your PR. What's changed? Why has it changed? Reference any GitHub issue this PR relates to, etc.

---

#### Pre-merge checklist

Before merging any PR, please check the following common things that should be done beforehand. These aren't all always required, so just check the box if it doesn't apply.

- [ ] **When adding files, make sure they're added to the right target**. If you're adding new files that should be bundled up with Cocoapods etc, they need to be added to the `TABTestKit` target, not `Pods-TABTestKit_Example` etc.
- [ ] **Run `pod install` to ensure that the latest changes are in the Example project**. Without this, Carthage might not see the latest changes.
- [ ] **Added and updated tests where possible**. This isn't always possible but try wherever you can. The example app contains UI tests to test many of the TABTestKit features.
- [ ] **Updated the `CHANGELOG`**. For any changes pending a release, add to the Pending section. For releases, move everything pending to the release section.
- [ ] **Updated the `README`**. Add info for any new features, update existing info for anything that's changed or needs extra info.
