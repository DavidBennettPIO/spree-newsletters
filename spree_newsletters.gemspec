Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_newsletters'
  s.version     = '1.2.0'
  s.summary     = 'Sends newsletters to subscribers'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'David Bennett'
  s.email             = 'david@bv.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 1.0.0')
  s.add_dependency('acts_as_list')
  s.add_dependency('delayed_job_active_record')
  s.add_dependency('daemons')

  s.add_dependency('mime-types')
  
  
end
