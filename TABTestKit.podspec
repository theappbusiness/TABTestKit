Pod::Spec.new do |s|
  s.name             = 'TABTestKit'
  s.version          = '1.8.0'
  s.summary          = 'Strongly typed Swift wrapper around XCTest / XCUI, enabling you to write BDD-style automation tests, without writing much code at all.'
  s.homepage         = 'https://github.com/theappbusiness/TABTestKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'zacoid55' => 'zac.borrelli@kinandcarta.com',
                         'KaneCheshire' => 'kane.cheshire@kinandcarta.com',
                         'theblixguy' => 'suyash.srijan@kinandcarta.com',
                         'neil3079' => 'neil.horton@kinandcarta.com',
                         'annpiktas' => 'anna.piktas@kinandcarta.com',
                         'roger-tan' => 'roger.tan@kinandcarta.com',
                         'jsanderson44' => 'john.sanderson@kinandcarta.com' }
  s.source           = { :git => 'https://github.com/theappbusiness/TABTestKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.4'
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
