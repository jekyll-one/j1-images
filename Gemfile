# ------------------------------------------------------------------------------
#  ~/Gemfile
#  Provides package information to bundle all Ruby gem needed
#  Docker Template
#
#  Product/Info:
#  https://jekyll-one.com
#
#  Copyright (C) 2019 Juergen Adams
#
#  J1 Template is licensed under the MIT License.
#  See: https://github.com/jekyll-one/j1_template_mde/blob/master/LICENSE
#
# ------------------------------------------------------------------------------
source "https://rubygems.org"

gem 'docker-template'

group :development do
  unless ENV["CI"] == "true"
    gem "travis"
    gem "pry"
  end
end
