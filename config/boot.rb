require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Amazon S3 Staging Settings

ENV['S3_BUCKET'] ||= 'bucket_tocarta_staging'
ENV['S3_KEY'] ||= 'AKIAJMUMLPY2TXXEPQEA'
ENV['S3_SECRET'] ||= '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'

# Amazon S3 Pro Settings

ENV['S3_BUCKET_PRO'] ||= 'bucket_tocarta_staging'
ENV['S3_KEY_PRO'] ||= 'AKIAJMUMLPY2TXXEPQEA'
ENV['S3_SECRET_PRO'] ||= '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'


# Twitter Settings

ENV['twitter_key'] ||= 'wWzY5QyaaotggYxS0nA'
ENV['twitter_secret'] ||= 'TpIC7BywlXdKIFJrayyATjj4nfboZsrUqLmsStzAVQ'
ENV['twitter_callback_url'] ||= 'http://tocarta-dev.heroku.com/sencha_touch_app/tw_redirect.html'




