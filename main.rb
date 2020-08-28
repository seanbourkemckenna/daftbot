require 'rss'
require 'open-uri'
require 'httparty'

def main
  get_links
end

def get_links
  url = "https://www.daft.ie/rss.daft?uid=1631460&id=1124033&xk=700151"
  open(url) do |rss|
    RSS::Parser.parse(rss).items.each {|item| send_to_slack(item.link)}
  end
end

def send_to_slack(link)
  HTTParty.post(
    "slack url",
    body: {
      channel: "#links",
      unfurl_links: true,
      username: "Daft Bot",
      icon_emoji: "house",
      text: link,
    }.to_json,
    headers: {
      "content-type" => "application/json",
    },
  )
end


main
