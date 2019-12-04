Pod::Spec.new do |s|
  s.name             = 'TABTestKit'
  s.version          = '1.1.1'
  s.summary          = 'Strongly typed Swift wrapper around XCTest / XCUI, enabling you to write BDD-style automation tests, without writing much code at all.'
  s.homepage         = 'https://github.com/theappbusiness/TABTestKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'zacoid55' => 'zac@theappbusiness.com',
                         'KaneCheshire' => 'kane.cheshire@theappbusiness.com',
                         'theblixguy' => 'suyash.srijan@theappbuisness.com' }
  s.source           = { :git => 'https://github.com/theappbusiness/TABTestKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version    = '5.0'
  s.source_files = 'TABTestKit/Classes/**/*'
  s.frameworks = 'XCTest'

  s.subspec 'Biometrics' do |b|
    b.source_files = 'TABTestKit/Classes/Biometrics/**/*'
  end
  s.subspec 'BDD' do |b|
    b.source_files = 'TABTestKit/Classes/BDD/**/*'
  end
  
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
