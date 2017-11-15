Pod::Spec.new do |s|
  s.name             = 'TABTestKit'
  s.version          = '0.2.2'
  s.summary          = 'Base to work off of for XCUI.'
  s.homepage         = 'https://github.com/theappbusiness/TABTestKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zacoid55' => 'zac@theappbusiness.com' }
  s.source           = { :git => 'https://github.com/theappbusiness/TABTestKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'TABTestKit/Classes/**/*'
  s.frameworks = 'XCTest'
end
