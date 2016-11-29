#!/usr/bin/env ruby
require 'rubygems'
require 'fog/aws'
require 'awscosts'

compute = Fog::Compute.new({
  :provider => 'AWS',
  :region => 'us-west-2'
})
# Retrieve pricing
region = AWSCosts.region 'us-west-2'

puts "Name,Instance Id,State,Availability Zone,Public IP,Private IP,Instance Type,Create Date,On-Demand Price Per Month"
compute.servers.each do |server|
  if server.platform.nil?
    price_per_month = region.ec2.on_demand(:linux).price(server.flavor_id)*24*30.4
  else
    price_per_month = region.ec2.on_demand(:windows).price(server.flavor_id)*24*30.4
  end
  puts "#{server.tags['Name']},#{server.id},#{server.state},#{server.availability_zone},#{server.public_ip_address},#{server.private_ip_address},#{server.flavor_id},#{server.created_at},#{price_per_month}"
end
