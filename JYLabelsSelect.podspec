Pod::Spec.new do |s|
s.name         = 'JYLabelsSelect'
s.version      = '1.0.0'
s.summary      = 'ios JYLabelsSelect install by cocoapods'
s.homepage     = 'https://github.com/CodingEverydayForFuture/JYLabelsSelect'
s.license      = 'MIT'
s.authors      = {'CodingEverydayForFuture' => '15238033727@163.com'}
s.platform     = :ios, '7.0'
s.source       = {:git => 'https://github.com/CodingEverydayForFuture/JYLabelsSelect.git', :tag => s.version}
s.source_files = 'JYLabelsSelect/JYLabelsSelect/LabelsSelect/*.{h,m}'
s.requires_arc = true

s.subspec 'tool' do |ss|
ss.source_files = 'JYLabelsSelect/JYLabelsSelect/LabelsSelect/tool/*.{h,m}'
end


end


