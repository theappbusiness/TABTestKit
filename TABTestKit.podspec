Pod::Spec.new do |s|
  s.name             = 'TABTestKit'
  s.version          = '0.3.4'
  s.summary          = 'Base to work off of for XCUI.'
  s.homepage         = 'https://github.com/theappbusiness/TABTestKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'zacoid55' => 'zac@theappbusiness.com' }
  s.source           = { :git => 'https://github.com/theappbusiness/TABTestKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'TABTestKit/Classes/**/*'
  s.frameworks = 'XCTest'
  s.dependency 'XCTest-Gherkin', '0.13.2'
end
