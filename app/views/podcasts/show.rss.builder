xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @podcast.name
    xml.description ""
    xml.link podcast_url(@podcast)

    for episode in @episodes
      xml.item do
        xml.title "#{@podcast.name} from #{episode.scheduled_at.strftime('%d.%m.%Y')}"
        xml.description ""
        xml.pubDate episode.finished_at.to_s(:rfc822)
        xml.link podcast_episode_url(@podcast, episode)
        xml.guid podcast_episode_url(@podcast, episode)
        xml.enclosure url: episode_file_url(episode), length: File.size(episode.path_and_filename), type: 'audio/mpeg'
      end
    end
  end
end