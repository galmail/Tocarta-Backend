require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Amazon S3 Staging Settings

ENV['S3_BUCKET'] ||= 'tocarta-test'
ENV['S3_KEY'] ||= 'AKIAJCY5PI67O7THQ5MQ'
ENV['S3_SECRET'] ||= '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'

# Amazon S3 Pro Settings

ENV['S3_BUCKET_PRO'] ||= 'tocarta-prod'
ENV['S3_KEY_PRO'] ||= 'AKIAJCY5PI67O7THQ5MQ'
ENV['S3_SECRET_PRO'] ||= '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'

# ENV['S3_BUCKET_PRO'] ||= 'bucket_tocarta_staging'
# ENV['S3_KEY_PRO'] ||= 'AKIAJMUMLPY2TXXEPQEA'
# ENV['S3_SECRET_PRO'] ||= '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'


# Twitter Settings

ENV['twitter_key'] ||= 'wWzY5QyaaotggYxS0nA'
ENV['twitter_secret'] ||= 'TpIC7BywlXdKIFJrayyATjj4nfboZsrUqLmsStzAVQ'
ENV['twitter_callback_url'] ||= 'http://tocarta-dev.heroku.com/sencha_touch_app/tw_redirect.html'




