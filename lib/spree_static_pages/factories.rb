FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_static_pages/factories'

  factory :static_page, class: Spree::StaticPage do
    name "Zardoz Speaks To You"
    path "/zardoz/speaks/to/you"
    text "Video: http://www.youtube.com/watch?v=kbGVIdA3dx0 *italics*"
    active_on { 1.day.ago }
  end
end
