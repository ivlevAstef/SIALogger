Pod::Spec.new do |s|

  s.name         = 'SIALogger'
  s.version      = '1.1.3'
  s.summary      = 'SIALogger - library for simplify log.'

  s.description  = <<-DESC
  					SIALogger - library for simplify log and assertion, for Objective-C (If you want to use SIALogger from Swift, see the ”SIALogger” pod.)
            Supported five log level: {Fatal, Error, Warning, Info, Trace}
            For more information see: https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Objective-C_v110

            DESC

  s.homepage     = 'https://github.com/ivlevAstef/SIALogger'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.documentation_url = 'https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Objective-C_v110'

  s.author       = { 'Alexander.Ivlev' => 'ivlev.stef@gmail.com' }
  s.source       = { :git => 'https://github.com/ivlevAstef/SIALogger.git', :tag => "v#{s.version}" }
  s.requires_arc = true

  s.ios.deployment_target = '5.0'

  s.source_files  = 'ObjC/SIALogger/SIALogger/SIALogger.h'
  s.public_header_files = 'ObjC/SIALogger/SIALogger/SIALogger.h'

  s.subspec 'Core' do |core|
    core.source_files  = 'ObjC/SIALogger/SIALogger/Core/**/*.{h,m}'
    core.public_header_files = 'ObjC/SIALogger/SIALogger/Core/**/*.h'
  end

  s.subspec 'Colorful' do |colorful|
    colorful.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -D__SIA_LOG_COLORFUL__' }
    
    colorful.dependency 'SIALogger/Core'
    
    colorful.source_files = 'ObjC/SIALogger/SIALogger/Colored/**/*.{h,m}'
    colorful.public_header_files = 'ObjC/SIALogger/SIALogger/Colored/**/*.h'
  end

  s.default_subspec = 'Core'

end
