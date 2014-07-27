require 'httparty'
require 'pry'

# To test on the command line
#
# PIVOTAL_API_TOKEN =
# PIVOTAL_PROJECT_ID =
# curl -X GET -H "X-TrackerToken: $PIVOTAL_API_TOKEN" "https://www.pivotaltracker.com/services/v5/projects/$PIVOTAL_PROJECT_ID/stories?filter=state:accepted%20type:feature"

# To run from ruby
# bundle exec ruby story.rb

token = ENV['PIVOTAL_API_TOKEN']
project_id = ENV['PIVOTAL_PROJECT_ID']

response = HTTParty.get("https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories?filter=state:accepted%20story_type:feature%20includedone:true", headers: {'X-TrackerToken' => token})

if response.is_a?(Hash) && response['kind'] == 'error'
  puts response
end

if response.is_a?(Array)
  response.each do |story|
    id = story['id']
    estimate = story['estimate']
    accepted_at = story['accepted_at']
    puts "#{id}, #{estimate}, #{accepted_at}"
  end
end

