Pod::Spec.new do |s|
  s.name          = 'DateKit'
  s.version       = '0.1.1'
  s.summary       = 'DateKit - operate on NSDate and its components easily in Swift'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.platform      = :ios , '7.0'
  s.homepage      = 'https://github.com/SnowdogApps/DateKit.git'
  s.requires_arc  = 'true'
  s.author        = {
    'Radosław Szeja' => 'r.szeja@snowdog.pl'
  }
  s.source        = {
    :git => 'https://github.com/SnowdogApps/DateKit.git',
    :tag => 'v0.1.1'
  }
  s.source_files  = 'DateKit/*.{h,swift}'

end
