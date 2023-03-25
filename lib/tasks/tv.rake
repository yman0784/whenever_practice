require 'mechanize'

namespace :tv do
  task tv_create:  :environment do
    Tv.destroy_all
    @tv = Tv.new
    agent = Mechanize.new
    page = agent.get('https://www.tvkingdom.jp/chart/56.action?head=&span=24&chartWidth=950&cellHeight=3&sticky=false&descriptive=true&buttonType=0')
    @elements = page.search('.td-schedule a')
    urls = []
    @elements.each do |ele| 
      urls << ele.get_attribute(:href) 
    end
    @data = []
    urls.each do |url| 
      data = {}
      page = agent.get(url) 
      if (page.search('h1').inner_text != "Gガイド.テレビ王国")
        data[:title] = page.search('h1').inner_text
        data[:overview] = page.search('html/body/div[6]/div[1]/div[2]/p[@class="basicTxt"]').inner_text
        data[:detail] = page.search('html/body/div[6]/div[1]/div[3]/p[@class="basicTxt"]').inner_text.gsub(/\n|\r\n|\r/,'').gsub(/\t/,'')
        data[:act] = page.search('/html/body/div[6]/div[1]/div[4]/p[@class="basicTxt"]').inner_text
        if page.search('/html/body/div[6]/div[1]/div[1]/dl/dd[1]/text()').inner_text != ""
          data[:time] = page.search('/html/body/div[6]/div[1]/div[1]/dl/dd[1]/text()').inner_text.gsub(/\n|\r\n|\r/,'').gsub(/\t/,'')
        elsif page.search('/html/body/div[6]/div[1]/div[1]/div/div/dl/text()').inner_text != ""
          data[:time] = page.search('/html/body/div[6]/div[1]/div[1]/div/div/dl/text()').inner_text.gsub(/\n|\r\n|\r/,'').gsub(/\t/,'')
        else 
          data[:time] = ""
        end
        @data << data
      end
      # sleep (0.1)
    end

    @data.each do |d| 
      Tv.create(title: d[:title], time: d[:time], overview: d[:overview], detail: d[:detail], act: d[:act])
    end
  end
end